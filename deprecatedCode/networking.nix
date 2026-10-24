{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      options,
      ...
    }:
    let
      inherit (lib)
        mkOption
        mkIf
        mkEnableOption
        optional
        elem
        types
        ;
      inherit (lib.types) str enum nullOr;
      cfg = config.losfelt.networking;
      hasPreservation = options ? preservation;
    in
    {
      options.losfelt.networking = {
        engine = {
          backend = mkOption {
            type = enum [
              "networkmanager"
              "systemd-networkd"
              "none"
            ];
            default = "networkmanager";

          };
          wifi = {
            enable = mkEnableOption "losfelt networking wifi";
            backend = mkOption {
              type = enum [
                "wpa_supplicant"
                "iwd"
              ];
              default = "wpa_supplicant";
              description = "Wireless networking";

            };
          };
          #not implemented
          dns = {
            mode = mkOption {
              type = elem [
                "default"
                "resolved"
              ];
              default = if cfg.engine.backend == "systemd-networkd" then "resolved" else "default";
            };
          };

        };

        access = {
          ssh = {
            mode = mkOption {
              type = enum [
                "disabled" # openssh off, idk why i would want that
                "tailscale-only" # only via tailscale can come in
                "keys-only" # hmm... yeah tailscale or via ssh key... idk why i want that either
                "hazard" # why not
              ];
              default = if cfg.access.tailscale.mode != "disabled" then "tailscale-only" else "disabled";
            };
            port = mkOption {
              type = types.port;
              default = 22;
              description = "OpenSSH port";
            };
          };
          tailscale = {
            mode = mkOption {
              type = enum [
                "disabled"
                "client"
                "exit-node"
                "subnet-router"
              ];
              default = "disabled";
              description = "tailscale mode option";
            };
            authKeyFile = mkOption {
              type = nullOr str;
              default = null;
              example = "/run/secrents/things";
            };

          };
        };
      };

      config = {
        warnings =
          optional (
            cfg.engine.backend == "none" && cfg.engine.wifi.enable
          ) "losfelt.networking: engine.backend is set to `none` while engine.wifi.enable is true"
          ++ optional (cfg.access.ssh.mode == "disabled") "OpenSSH disabled";

        # Engine
        networking.networkmanager.enable = cfg.engine.backend == "networkmanager";
        systemd.network.enable = cfg.engine.backend == "systemd-networkd";

        # Engine wifi
        networking.wireless.enable = mkIf (cfg.engine.backend != "networkmanager") (
          cfg.engine.wifi.enable && cfg.engine.wifi.backend == "wpa_supplicant"
        );
        networking.wireless.iwd.enable =
          cfg.engine.wifi.enable
          && cfg.engine.wifi.backend == "iwd"
          && cfg.engine.backend != "networkmanager";

        networking.networkmanager.wifi.backend = mkIf (
          cfg.engine.backend == "networkmanager" && cfg.engine.wifi.enable
        ) cfg.engine.wifi.backend;

        services.openssh = {
          enable = cfg.access.ssh.mode != "disabled";
          ports = [ cfg.access.ssh.port ];
          settings = {
            PermitRootLogin =
              if
                elem cfg.access.ssh.mode [
                  "keys-only"
                  "tailscale-only"
                ]
              then
                "prohibit-password"
              else
                "no";
            PasswordAuthentication = cfg.access.ssh.mode == "hazard";
            KbdInteractiveAuthentication = cfg.access.ssh.mode == "hazard";
          };
        };

        services.tailscale = {
          enable = cfg.access.tailscale.mode != "disabled";
          authKeyFile = cfg.access.tailscale.authKeyFile;
          useRoutingFeatures = mkIf (
            elem cfg.access.tailscale.mode == [
              "exit-node"
              "subnet-router"
            ]
          ) "both";
        };
        boot.kernel.sysctl =
          mkIf
            (
              elem cfg.access.tailscale.mode == [
                "exit-node"
                "subnet-router"
              ]
            )
            {
              "net.ipv4.ip_forward" = 1;
              "net.ipv6.conf.all.forwarding" = 1;
            };

        networking.firewall.enable = true;
        networking.firewall.allowedTCPPorts = optional (elem cfg.access.ssh.mode [
          "keys-only"
          "hazard"
        ]) cfg.access.ssh.port;
      };

    };
}

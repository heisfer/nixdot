{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      options,
      ...
    }:
    let
      inherit (lib)
        mkOption
        mkEnableOption
        mkIf
        mkMerge
        elem
        optional
        ;
      inherit (lib.types)
        enum
        listOf
        bool
        port
        ;
      cfg = config.losfelt.networking.ssh;
      hasPreservation = options ? preservation;
    in
    {
      options.losfelt.networking.ssh = {
        enable = mkEnableOption "OpenSSH";
        reachableFrom = mkOption {
          type = listOf (enum [
            "tailnet"
            "public"
          ]);
          default = [ ];
          description = "Where sshd accepts connections from. Empty means localhost only.";
        };
        passwordAuth = mkOption {
          type = bool;
          default = false;
        };
        port = mkOption {
          type = port;
          default = 22;
        };
      };

      config = mkIf cfg.enable (mkMerge [
        {
          services.openssh = {
            enable = true;
            ports = [ cfg.port ];
            openFirewall = elem "public" cfg.reachableFrom;
            settings = {
              PermitRootLogin = "no";
              PasswordAuthentication = cfg.passwordAuth;
              KbdInteractiveAuthentication = cfg.passwordAuth;
            };
          };

          networking.firewall.interfaces.tailscale0.allowedTCPPorts =
            optional (elem "tailnet" cfg.reachableFrom) cfg.port;

          assertions = [
            {
              assertion = !(elem "tailnet" cfg.reachableFrom) || config.losfelt.networking.tailscale.enable;
              message = "losfelt.networking.ssh: reachableFrom includes `tailnet`, but losfelt.networking.tailscale.enable is false";
            }
          ];
        }

        # (mkIf hasPreservation {
        #   services.openssh.hostKeys = [
        #     {
        #       path = "/persist/etc/ssh/ssh_host_ed25519_key";
        #       type = "ed25519";
        #     }
        #   ];
        # })
      ]);
    };
}

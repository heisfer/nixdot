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
        optional
        optionalAttrs
        mapAttrs
        toUpper
        ;
      inherit (lib.types)
        str
        nullOr
        enum
        bool
        attrsOf
        submodule
        ;
      cfg = config.losfelt.networking.wifi;
      hasPreservation = options ? preservation;
    in
    {
      options.losfelt.networking.wifi = {
        enable = mkEnableOption "NetworkManager with Wi-Fi";

        backend = mkOption {
          type = enum [
            "wpa_supplicant"
            "iwd"
          ];
          default = "wpa_supplicant";
        };

        environmentFile = mkOption {
          type = nullOr str;
          default = null;
          description = "File of VAR=password lines (e.g. a sops-nix secret path). Never put passwords in Nix options.";
        };

        networks = mkOption {
          default = { };
          description = "Declared Wi-Fi networks.";
          type = attrsOf (
            submodule (
              { name, ... }: {
                options = {
                  ssid = mkOption {
                    type = str;
                    default = name;
                  };
                  secured = mkOption {
                    type = bool;
                    default = true;
                    description = "Set false for open networks.";
                  };
                  pskVariable = mkOption {
                    type = str;
                    default = "WIFI_${toUpper (builtins.replaceStrings [ "-" " " ] [ "_" "_" ] name)}_PSK";
                    description = "Variable in environmentFile that holds this network's password.";
                  };
                };
              }
            )
          );
        };
      };

      config = mkIf cfg.enable (mkMerge [
        {
          networking.networkmanager = {
            enable = true;
            wifi.backend = cfg.backend;
          };

          assertions = [
            {
              assertion =
                builtins.all (n: !n.secured) (builtins.attrValues cfg.networks) || cfg.environmentFile != null;
              message = "losfelt.networking.wifi: secured networks need wifi.environmentFile";
            }
          ];
        }

        (mkIf (cfg.networks != { }) {
          networking.networkmanager.ensureProfiles = {
            environmentFiles = optional (cfg.environmentFile != null) cfg.environmentFile;
            profiles = mapAttrs (
              name: n:
              {
                connection = {
                  id = name;
                  type = "wifi";
                };
                wifi = {
                  ssid = n.ssid;
                  mode = "infrastructure";
                };
                ipv4.method = "auto";
                ipv6.method = "auto";
              }
              // optionalAttrs n.secured {
                wifi-security = {
                  key-mgmt = "wpa-psk";
                  psk = "$${n.pskVariable}";
                };
              }
            ) cfg.networks;
          };
        })

        (optionalAttrs hasPreservation {
          preservation.preserveAt."/persist".directories = [
            {
              directory = "/etc/NetworkManager/system-connections";
              mode = "0700";
            }
          ];
        })
      ]);
    };
}

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
        optionalAttrs
        ;
      inherit (lib.types) enum nullOr str;
      cfg = config.losfelt.networking.tailscale;
      hasPreservation = options ? preservation;

      # role -> routing features
      routing = {
        client = "client";
        exit-node = "both";
        subnet-router = "both";
      };
    in
    {
      options.losfelt.networking.tailscale = {
        enable = mkEnableOption "Tailscale";
        role = mkOption {
          type = enum (builtins.attrNames routing);
          default = "client";
        };
        authKeyFile = mkOption {
          type = nullOr str;
          default = null;
          example = "/run/secrets/tailscale";
        };
      };

      config = mkIf cfg.enable (mkMerge [
        {
          services.tailscale = {
            enable = true;
            authKeyFile = cfg.authKeyFile;
            useRoutingFeatures = routing.${cfg.role};
          };
        }

        (optionalAttrs hasPreservation {
          preservation.preserveAt."/persist".directories = [ "/var/lib/tailscale" ];
        })
      ]);
    };
}

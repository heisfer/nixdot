{
  flake.nixosModules.losfelt =
    { lib, config, ... }:
    let
      inherit (lib) mkOption;
      inherit (lib.types) str;

      cfg = config.losfelt.networking.identity;
    in
    {

      options.losfelt.networking.identity = {
        name = mkOption {
          type = str;
          example = "nixos-lol";
          description = "System hostName";
        };
        id = mkOption {
          type = str;
          default = null;
          description = "System hostName";
        };
      };

      config = {

        networking.hostName = cfg.name;
        networking.hostId = cfg.id;
      };
    };

}

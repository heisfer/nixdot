{
  flake.nixosModules.losfelt =
    { lib, config, ... }:
    let
      inherit (lib) mkOption;
      inherit (lib.types)
        enum
        listOf
        str
        attrsOf
        ;
      cfg = config.losfelt.settings;
    in
    {
      options.losfelt.settings = {
        # expreimental idk add hosts/name/roles.nix or define global;
        userRoles = mkOption {
          type = attrsOf (listOf str);
          default = {
            sudo = [ "wheel" ];
          };
        };
        defaultUserRole = mkOption {
          type = enum (builtins.attrNames cfg.userRoles);
          default = "sudo";
        };
        # enable it wherever you want
        userProfiles = mkOption {
          type = attrsOf (listOf str);
          default = {
            idk = [ "could be something to enable multiple things on user settings idk" ];
          };
        };
        #maybe make default userProfiles

      };

    };

}

{ inputs, self, ... }:
{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkOption
        mkEnableOption
        filterAttrs
        mapAttrs
        pathExists
        optional
        optionalAttrs
        ;
      inherit (lib.types)
        bool
        str
        listOf
        package
        nullOr
        attrsOf
        submodule
        deferredModule
        ;
      cfg = config.losfelt.users;
      homeDir = name: "${self}/homes/${name}";

      userOpts = { name, ... }: {
        options = {
          enable = mkEnableOption "${name} user" // {
            default = true;
          };

          enableHjem = mkOption {
            type = bool;
            default = pathExists (homeDir name);
            description = "Manage this user's home with hjem. Defaults to true when homes/<name> exists.";
          };

          fullName = mkOption {
            type = str;
            default = name;
          };

          groups = mkOption {
            type = listOf str;
            default = [ ];
          };

          shell = mkOption {
            type = package;
            default = pkgs.fish;
          };

          hashedPasswordFile = mkOption {
            type = nullOr str;
            default = null;
            description = "Path to file containing user's password hash.";
          };

          hashedPassword = mkOption {
            type = nullOr str;
            default = null;
            description = "Password hash string. Prefer hashedPasswordFile.";
          };

          home = mkOption {
            type = deferredModule;
            default = { };
            description = "Extra inline hjem module, applied on top of homes/<name>/.";
          };
        };
      };

      enabledUsers = filterAttrs (_: u: u.enable) cfg;
      hjemUsers = filterAttrs (_: u: u.enableHjem) enabledUsers;
    in
    {
      imports = [ inputs.hjem.nixosModules.default ];

      options.losfelt.users = mkOption {
        type = attrsOf (submodule userOpts);
        default = { };
        description = "users managed by losfelt egosystem";
      };

      config = {
        services.userborn = {
          enable = true;
          passwordFilesLocation = "/var/lib/userborn";
        };

        users.users = mapAttrs (username: u: {
          isNormalUser = true;
          description = u.fullName;
          extraGroups = u.groups;
          inherit (u) hashedPasswordFile hashedPassword shell;
        }) enabledUsers;
        hjem = {
          specialArgs = {inherit inputs;};
        };

        hjem.users = mapAttrs (name: u: {
          enable = true;
          imports = [ u.home ] ++ optional (pathExists (homeDir name)) (inputs.import-tree (homeDir name));
        }) hjemUsers;
      };
    };
}

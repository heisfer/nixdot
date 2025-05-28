{
  config,
  lib,
  ...
}:
let
  ## most of the stuff is migrated from home-manager repo
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types)
    lines
    listOf
    str
    attrsOf
    bool
    nullOr
    oneOf
    path
    submodule
    ;
  inherit (lib.attrsets)
    attrNames
    filterAttrs
    genAttrs
    mapAttrs
    ;
  inherit (lib.lists) length;
  cfg = config.userspace;

in
{
  options.userspace = {
    users = mkOption {
      default = { };
      description = "Hjem & users.users combined";
      type = attrsOf (
        submodule (
          { config, name, ... }:
          {
            options = {
              username = mkOption {
                type = str;
                default = name;
                description = "Username";
              };
              initialPassword = mkOption {
                type = str;
                default = "password";
                description = "User password";
              };
              isDefault = mkOption {
                type = bool;
                default = false;
              };
              isTrusted = mkOption {
                type = bool;
                default = false;
                description = "Add user to trusted users list";
              };
              groups = mkOption {
                type = listOf str;
                default = [ ];
              };
              enableHjem = mkEnableOption "hjem";
            };
          }
        )
      );
    };

    defaultUser = mkOption {
      type = str;
      readOnly = true;
      description = "Default user";
    };
    hjemUsers = mkOption {
      type = listOf str;
      readOnly = true;
      description = "List of users for hjem";
    };
  };
  config =
    let
      defaultUsers = attrNames (filterAttrs (username: users: users.isDefault) cfg.users);
    in
    {
      assertions = [
        {
          assertion = length defaultUsers == 1;
          message =
            "Must be exactly one default user but found "
            + builtins.toString (length defaultUsers)
            + ". "
            + lib.optionalString (length defaultUsers > 1) (builtins.toString defaultUsers)
            + lib.optionalString (
              length defaultUsers < 1
            ) "Set default user by userspace.users.<UserName>.isDefault = true;";
        }
      ];

      userspace.defaultUser = builtins.toString defaultUsers;

      userspace.hjemUsers = attrNames (filterAttrs (username: users: users.enableHjem) cfg.users);

      users.users = mapAttrs (user: value: {
        isNormalUser = true;
        initialPassword = value.initialPassword;
        extraGroups = value.groups;
      }) cfg.users;

      nix.settings.trusted-users = attrNames (filterAttrs (username: users: users.isTrusted) cfg.users);

      hjem.users = genAttrs cfg.hjemUsers (user: {
        enable = true;
      });

      hjem.clobberByDefault = true;
    };

}

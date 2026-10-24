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
        mkEnableOption
        mkIf
        any
        hasInfix
        ;

      cfg = config.losfelt.shells.fish;

      # Auto-detect if any enabled losfelt user is running fish
      hasFishUser = any (u: u.enable && hasInfix "fish" (u.shell.name or "")) (
        builtins.attrValues (config.losfelt.users or { })
      );
    in
    {
      options.losfelt.shells.fish = {
        enable = mkEnableOption "losfelt Fish shell environment" // {
          default = hasFishUser;
        };
      };

      config = mkIf cfg.enable {
        programs.fish = {
          enable = true;
          vendor.completions.enable = true;
        };
      };
    };
}

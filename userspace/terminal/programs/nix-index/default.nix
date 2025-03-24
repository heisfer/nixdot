{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];

  # Thanks Xarvex
  programs.nix-index.package =
    inputs.nix-index-database.packages.${pkgs.system}.nix-index-with-db.override
      {
        nix-index-unwrapped = pkgs.nix-index-unwrapped.overrideAttrs (o: {
          postInstall =
            ''
              substituteInPlace command-not-found.sh \
                --replace-fail '[ -e "$HOME/.nix-profile/manifest.json" ]' true
            ''
            + (o.postInstall or "");
        });
      };

}

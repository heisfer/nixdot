{
  pkgs,
  inputs,
  ...
}: let
  marketplace-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  private-extension = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "phpactor";
      version = "1.2.0";
      publisher = "phpactor";
    };
    vsix = builtins.fetchurl {
      url = "https://github.com/phpactor/vscode-phpactor/releases/download/1.2.0/phpactor.vsix";
      sha256 = "1jpaqqkfi7170hj2nfnxxb2ppw2pciladqg5v765nmpkgss31hvg";
    };
    buildInputs = [pkgs.libarchive];
    unpackPhase = ''
      bsdtar xvf "$src" --strip-components=1 'extension/*'
    '';
  };
  ui = with marketplace-extensions; [
    silverquark.dancehelix
    mvllow.rose-pine
    sulsami.rose-pine-burnt
  ];
  misc = with marketplace-extensions; [
    mkhl.direnv
  ];
in {
  programs.vscode.extensions =
    [
      private-extension
    ]
    ++ ui
    ++ misc;
}

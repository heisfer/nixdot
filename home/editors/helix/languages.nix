{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.helix.languages = {
    language-server = {
      phpactor = {
        command = "${pkgs.phpactor}/bin/phpactor";
        args = ["language-server"];
      };
      intelephense = {
        command = "${pkgs.nodePackages_latest.intelephense}/bin/intelephense";
        args = ["--stdio"];
      };
      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
      };
      nixd = {
        command = "${inputs.nixd.packages.${pkgs.system}.default}/bin/nixd";
      };
      vscode-css-language-server = {
        command = "${pkgs.nodePackages_latest.vscode-css-languageserver-bin}/bin/css-languageserver";
        args = ["--stdio"];
        config = {
          provideFormatter = true;
          css = {
            validate = {
              enable = true;
            };
          };
        };
      };
    };
    language = [
      {
        name = "php";
        auto-format = true;
        file-types = ["php" "inc"];
        shebangs = ["php"];
        language-servers = ["phpactor"];
        roots = ["composer.json" "index.php"];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
      {
        name = "nix";
        language-servers = ["nixd"];
        auto-format = true;
        roots = [".nixd.json" "flake.nix" ".git"];
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
      {
        name = "css";
        auto-format = true;
        file-types = ["css" "scss"];
        injection-regex = "css";
        scope = "source.css";
        language-servers = ["vscode-css-language-server"];
      }
    ];
  };
}

{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language-server = {
      phpactor = {
        command = "${pkgs.phpactor}/bin/phpactor";
        args = ["language-server"];
      };
      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
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

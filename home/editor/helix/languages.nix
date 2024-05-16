{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.helix.languages = {
    language-server = {
      nil = {
        command = "${lib.getExe inputs.nil.packages.${pkgs.system}.default}";
        config.nil.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
      };
      vscode-html-language-server = {
        command = "${lib.getExe' pkgs.vscode-langservers-extracted "vscode-html-language-server"}";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
        };
      };
      emmet-lsp = {
        command = "${lib.getExe pkgs.emmet-language-server}";
        args = [ "--stdio" ];
      };
      intelephense = {
        command = "${lib.getExe' pkgs.nodePackages_latest.intelephense "intelephense"}";
        args = [ "--stdio" ];
      };
      phpactor = {
        command = "${lib.getExe' pkgs.phpactor "phpactor"}";
        args = [ "language-server" ];
      };
    };
    language =
      let
        phplsp = [
          {
            name = "intelephense";
            only-features = [
              "format"
              "completion"
              "diagnostics"
              "inlay-hints"
            ];
          }
          {
            name = "phpactor";
            except-features = [
              "format"
              "completion"
              "diagnostics"
            ];
          }
        ];
      in
      [
        {
          name = "nix";
          language-servers = [ "nil" ];
          scope = "source.nix";
          injection-regex = "nix";
          auto-format = true;
          file-types = [ "nix" ];
          comment-token = "#";
        }
        {
          name = "html";
          language-servers = [
            "emmet-lsp"
            "vscode-html-language-server"
          ];
          auto-pairs = true;
          injection-regex = "html";
          file-types = [ "html" ];
        }
        {
          name = "php";
          auto-format = true;
          language-servers = phplsp;
        }
        {
          name = "blade";
          scope = "source.blade.php";
          file-types = [
            { glob = "*.blade.php"; }
            "blade"
          ];
          injection-regex = "blade";
          language-servers = [ "vscode-html-language-server" ];
          roots = [
            "composer.json"
            "index.php"
          ];
        }
        {
          name = "gohtml";
          scope = "source.gohtml";
          injection-regex = "gohtml";
          file-types = [ "gohtml" ];
          language-servers = [
            "vscode-html-language-server"
            "emmet-lsp"
          ];
          # language-servers = [ "gopls" ];
        }
      ];
    grammar = [
      {
        name = "gohtml";
        source.git = "https://github.com/heisfer/tree-sitter-go-html-template";
        source.rev = "d9b4f708018403be8a120cb25917c20bf297cff5";
      }
    ];
  };
}

{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.helix = {
    languages = {
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
      };
      language = [
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
          language-servers = [ "vscode-html-language-server" ];
          auto-pairs = true;
          injection-regex = "html";
          file-types = [ "html" ];
        }
        {
          name = "gohtml";
          scope = "source.gohtml";
          injection-regex = "gohtml";
          file-types = [ "gohtml" ];
          language-servers = [ "vscode-html-language-server" ];
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
  };
}

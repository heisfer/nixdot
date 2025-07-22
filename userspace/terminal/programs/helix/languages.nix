{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib.meta) getExe getExe';
  home = config.users.users.heisfer.home;
  hostname = config.networking.hostName;

in
{
  # Addidng ref to upstream languages.toml so i don't have to search it manually
  # https://github.com/helix-editor/helix/blob/master/languages.toml
  # Preconfigured lsp's
  programs.helix.extraPackages = with pkgs; [
    taplo
    yaml-language-server
    bash-language-server
    lua-language-server
    vscode-langservers-extracted
    # Pre configured rust
    rust-analyzer
    clippy
    rustc
    vala-language-server
    typescript-language-server
  ];
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = getExe inputs.nixd.packages.${pkgs.system}.default;
        config.nixd = {
          formatting.command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
          options = {
            nixpkgs.expr = "import <nixpkgs> {}";
            # nixos.expr = "(builtins.getFlake \"${home}/Projects/system/dots\").nixosConfigurations.${hostname}.options";
          };
        };
      };
      marksman = {
        command = getExe pkgs.marksman;
        args = [ "server" ];
      };
      mpls = {
        command = getExe pkgs.mpls;
        args = [
          "--dark-mode"
          "--enable-footnotes"
          "--enable-wikilinks"
          "--enable-emoji"
        ];
      };

      nil = {
        command = getExe inputs.nil.packages.${pkgs.system}.default;
      };
      mdpls = {
        command = getExe pkgs.local.mdpls;
        config = {
          markdown.preview.auto = true;
          markdown.preview.browser = "firefox-devedition";
        };
      };
      go-grip = {
        command = getExe pkgs.local.go-grip;
      };
      nu-lsp = {
        command = getExe pkgs.nushell;
        args = [ "--lsp" ];
      };
      phpactor = {
        command = getExe pkgs.phpactor;
        args = [ "language-server" ];
      };
      rust-analyzer.config = {
        check.command = "clippy";
      };
      qmlls = {
        command = getExe' pkgs.qt6.qtdeclarative "qmlls";
        args = [ "-E" ];
      };
    };
    language = [
      {
        name = "nix";
        language-servers = [
          "nixd"
          # "nil"
        ];
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [
          "marksman"
          "go-grip"
        ];
      }
      {
        name = "php";
        language-servers = [
          "phpactor"
        ];
      }
      {
        name = "nu";
        language-servers = [ "nu-lsp" ];
      }
      {
        name = "qml";
        language-servers = [ "qmlls" ];
      }
    ];
  };
}

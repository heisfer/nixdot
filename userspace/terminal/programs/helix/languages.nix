{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.meta) getExe;
  home = config.users.users.heisfer.home;
  hostname = config.networking.hostName;
in
{
  # Addidng ref to upstream languages.toml so i don't have to search it manually
  # https://github.com/helix-editor/helix/blob/master/languages.toml
  # Preconfigured lsp's
  programs.helix.extraPackages = with pkgs; [
    nil
    taplo
    yaml-language-server
    bash-language-server
    lua-language-server
    # Pre configured rust
    rust-analyzer
    clippy
    rustc
  ];
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = getExe pkgs.nixd;
        config.nixd = {
          formatting.command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
          options = {
            nixpkgs.expr = "import <nixpkgs> {}";
            nixos.expr = "(builtins.getFlake \"${home}/Projects/system/dots\").nixosConfigurations.${hostname}.options";
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
      rust-analyzer.config = {
        check.command = "clippy";
      };
    };
    language = [
      {
        name = "nix";
        language-servers = [ "nixd" ];
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
        name = "nu";
        language-servers = [ "nu-lsp" ];
      }
    ];
  };
}

{ pkgs, lib, ... }:
let
  inherit (lib.meta) getExe;
in
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = getExe pkgs.nixd;
        config.nixd = {
          formatting.command = [ "${getExe pkgs.nixfmt-rfc-style}" ];
        };
      };
      nil = {
        command = getExe pkgs.nil;
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
      nu-lsp = {
        command = getExe pkgs.nushell;
        args = [ "--lsp" ];
      };
    };
    language = [
      {
        name = "nix";
        language-servers = [
          "nixd"
          "nil"
        ];
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [
          "marksman"
          "mpls"
        ];
      }
      {
        name = "nu";
        language-servers = [ "nu-lsp" ];
      }
    ];
  };
}

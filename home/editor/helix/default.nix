{ pkgs, inputs, ... }:
{
  imports = [ ./languages.nix ];
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    settings = {
      theme = "rose_pine";
      editor = {
        line-number = "relative";
        idle-timeout = 0;
        auto-format = true;
        auto-completion = true;
        mouse = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        file-picker = {
          hidden = false;
        };
      };
      keys.normal = {
        space.q = ":q";
      };
    };
  };
}

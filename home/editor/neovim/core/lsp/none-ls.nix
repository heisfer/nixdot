{ pkgs, ... }:
{

  programs.neovim = {
    extraPackages = with pkgs; [
      stylua
      statix
    ];
    plugins = with pkgs.vimExtraPlugins; [
      {
        plugin = none-ls-nvim;
        type = "lua";
        config = ''
          local null_ls = require("null-ls")

          null_ls.setup({
            sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.completion.spell,
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.formatting.nixfmt,
            },
          })
        '';
      }
    ];
  };
}

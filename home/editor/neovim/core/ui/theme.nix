{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = rose-pine;
      type = "lua";
      config = ''
        vim.cmd("colorscheme rose-pine")
      '';
    }
  ];
}

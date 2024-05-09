{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require('lualine').setup()
      '';
    }
  ];
}

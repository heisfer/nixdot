{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = ultimate-autopair-nvim;
      type = "lua";
      config = ''
        require('ultimate-autopair').setup()
      '';
    }
  ];
}

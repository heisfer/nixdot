{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = fidget-nvim;
      type = "lua";
      config = ''
        require("fidget").setup()
      '';
    }
  ];
}

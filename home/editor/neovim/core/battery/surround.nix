{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = nvim-surround;
      type = "lua";
      config = ''
        require("nvim-surround").setup()
      '';
    }
  ];
}

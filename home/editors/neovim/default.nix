{pkgs, ...}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      phpactor
      cmp_luasnip
      cmp-nvim-lsp

      {
        plugin = wilder-nvim;
	config = toLuaFile ./lua/plugins/wilder.lua;
      }

      {
        plugin = gitsigns-nvim;
	config = toLuaFile ./lua/plugins/gitsigns.lua;
      }
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons

      neodev-nvim
	  {
	    plugin = nvim-cmp;
		config = toLuaFile ./lua/plugins/cmp.lua;
      }
      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./lua/plugins/lsp.lua;
      }

      {
        plugin = neovim-ayu;
        config = "colorscheme ayu-dark";
      }

    ];

    extraLuaConfig = ''
      ${builtins.readFile ./lua/options.lua}
    '';
  };
}

{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimExtraPlugins; [
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp
      cmp-luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")

          cmp.setup({
          	snippet = {
          		expand = function(args)
          			require("luasnip").lsp_expand(args.body)
          		end,
          	},
          	mapping = cmp.mapping.preset.insert({
          		["<c-p>"] = cmp.mapping.select_prev_item(cmp_select),
          		["<c-n>"] = cmp.mapping.select_next_item(cmp_select),
          		["<c-y>"] = cmp.mapping.confirm({ select = true }),
          		["<c-space"] = cmp.mapping.complete(),
          	}),

          	sources = cmp.config.sources({
          		{ name = "nvim_lsp" },
          		{ name = "luasnip" },
              { name = "buffer" },
              { name = "path" },
          	}),
          })
        '';
      }
    ];
  };
}

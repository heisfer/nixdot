{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = ''
        require('gitsigns').setup()
        vim.keymap.set("n", "<leader>hp", require('gitsigns').preview_hunk, { desc = "Gitsings: preview_hunk" })
        vim.keymap.set("n", "<leader>hb", require('gitsigns').toggle_current_line_blame, { desc = "Gitsings: toggle line blame" })
        
      '';
    }
  ];
}

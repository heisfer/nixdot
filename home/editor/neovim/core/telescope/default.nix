{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [ ripgrep ];
    plugins = with pkgs.vimExtraPlugins; [
      plenary-nvim
      telescope-file-browser-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup({})
          require('telescope').load_extension('file_browser')
          vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = "Telescope: Find Files" })
          vim.keymap.set('n', '<leader>fe', ":Telescope file_browser<CR>", { desc = "Telescope: Find Files" })
          vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = "Telescope: Live Grep" })    
          vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = "Telescope: Buffers" })
          vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = "Telescope:Diagnostics" })
          vim.keymap.set('n', '<leader>dd', function() require('telescope.builtin').diagnostics() end, { desc = "Telescope: Diagnostics"})
          vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end, { desc = "Telescope: Git status" })
          vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_branhes() end, { desc = "Telescope: Git Branches"})
        '';
      }
    ];
  };
}

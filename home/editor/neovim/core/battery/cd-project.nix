{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimExtraPlugins; [
    {
      plugin = cd-project-nvim;
      type = "lua";
      config = ''
        require("cd-project").setup({
          projects_picker = "telescope",
          project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
        })
        vim.keymap.set("n", "<leader>fp", ":CdProject<CR>", { desc = "Browse Projects" })
      '';
    }
  ];
}

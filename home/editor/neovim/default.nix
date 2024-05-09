{
  imports = [ ./core ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " " -- set space to leader key

      vim.opt.number = true
      vim.opt.relativenumber = true

      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.showtabline = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true


      vim.opt.smartindent = true
      vim.opt.breakindent = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true

      vim.opt.cursorline = true
      vim.opt.guicursor = ""
      vim.opt.nu = true;


      vim.opt.wrap = false

      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undofile = true


      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.infercase = true
      vim.opt.completeopt = "menuone,noselect,noinsert"

      vim.opt.cursorline = true;


    '';
  };
}

{
  pkgs
,  ...
}: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      #lsp
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      phpactor
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        tree-sitter-bash
        tree-sitter-css
        tree-sitter-nix
        tree-sitter-html
        tree-sitter-php
        tree-sitter-sql
        tree-sitter-python
        tree-sitter-toml
        tree-sitter-lua
        tree-sitter-yaml
      ]))
      
    ];
  };
}

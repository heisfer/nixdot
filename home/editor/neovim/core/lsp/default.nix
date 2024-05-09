{ pkgs, ... }:
{
  imports = [ ./none-ls.nix ];
  programs.neovim = {
    extraPackages = with pkgs; [
      lua-language-server
      nil
      nixfmt-rfc-style
      gopls
      vscode-langservers-extracted
      htmx-lsp
      emmet-language-server
    ];
    plugins = with pkgs.vimExtraPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lsp.lua;
      }
    ];
  };
}

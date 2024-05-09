{ pkgs, ... }:
{
  xdg.configFile = {
    "nvim/queries/nix/injections.scm".source = ./queries/nix/injections.scm;
    #"nvim/ftplugin/gohtmltmpl.vim".source = ./ftdetect/gohtmltmpl.vim;
    #"nvim/queries/gohtmltmpl/injections.scm".source = ./queries/gohtmltmpl/injections.scm;
    #"syntax/gohtmltmpl.vim".source = ./syntax/gohtmltmpl.vim;
    #"ftplugin/gohtmltmpl.vim".source = ./ftplugin/gohtmltmpl.vim;
    #"indent/gohtmltmpl.vim".source = ./indent/gohtmltmpl.vim;
    #"nvim/queries/gohtmltmpl/highlights.scm".source = ./queries/gohtmltmpl/highlights.scm;
  };
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-go
      nvim-treesitter-parsers.gotmpl
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
          })
        '';
      }
    ];
    extraConfig = ''
      function DetectGoHtmlTmpl()
          if expand('%:e') == "html" && search("{{") != 0
              setfiletype gohtmltmpl
          endif
      endfunction

      augroup filetypedetect
          " gohtmltmpl
          au BufRead,BufNewFile *.html call DetectGoHtmlTmpl()
      augroup END
    '';
  };
}

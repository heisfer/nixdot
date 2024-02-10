{
  inputs,
  pkgs,
  ...
}: {
  imports = [./languages.nix];

  programs.helix = {
    enable = true;
    # using master branch of helix instead of nixpkgs
    # https://github.com/helix-editor/helix/discussions/6062
    package = inputs.helix.packages.${pkgs.system}.default;
    defaultEditor = true;
    settings = {
      theme = "rose_pine";

      editor = {
        line-number = "relative";
        cursorline = true;
        auto-format = true;
        mouse = false;
        popup-border = "all";
        rainbow-brackets = true;
        sticky-context = {
          enable = true;
          indicator = false;
        };
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
        };
        whitespace.render = "none";
        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };

      keys.normal = {
        #colemak stuff
        y = ["yank" "yank_main_selection_to_clipboard"];

        C-f = [":new" ":insert-output lf" ":theme default" "select_all" "split_selection_on_newline" "goto_file" "goto_last_modified_file" ":buffer-close!" ":theme tokyonight_storm"];
        space.space = "file_picker";
        space.t = ":sh wezterm cli split-pane --bottom --percent 30 --cwd $(pwd)";
        space.w = ":w";
        space.q = ":q";
        esc = ["collapse_selection" "keep_primary_selection"];
        C-x = ":append-output xplr"; # (Ctrl-x, or whatever you want)
      };

      keys.normal.space.u = {
        f = ":format";
      };
    };
  };
}

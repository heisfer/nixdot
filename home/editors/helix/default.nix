{
  inputs,
  ...
}: {

  imports = [./languages.nix];

  
  programs.helix = {
    enable = true;
    # using master branch of helix instead of nixpkgs
    # https://github.com/helix-editor/helix/discussions/6062
    package = inputs.helix.packages."x86_64-linux".default;
    defaultEditor = true;
    settings = {
      theme = "ayu_dark";
      
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "bar";
          select = "underline";
        };
      };

      keys.normal = {
        #colemak stuff
        n = "move_char_left";
        e = "move_line_down";
        i = "move_line_up";
        o = "move_char_right";

        u = "insert_mode";
        U = "insert_at_line_start";

        l = "open_below";
        L = "open_above";

        k = "move_next_word_end";
        K = "move_next_long_word_end";

        j = "search_next";
        J = "search_prev";

        C-f = [":new" ":insert-output lf" ":theme default" "select_all" "split_selection_on_newline" "goto_file" "goto_last_modified_file" ":buffer-close!" ":theme tokyonight_storm"];
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };

      keys.normal.space.u = {
        f = ":format";
      };

    };
  };
}
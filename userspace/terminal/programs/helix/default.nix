{
  imports = [
    ./languages.nix
  ];
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
      editor = {
        completion-timeout = 5;
        completion-trigger-len = 1;
        color-modes = true;
        end-of-line-diagnostics = "hint";
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          ignore = true;
        };
        lsp = {
          display-inlay-hints = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
      keys = {
        normal = {
          tab = "move_parent_node_end";
          S-tab = "move_parent_node_start";
        };
        insert = {
          S-tab = "move_parent_node_start";
        };
        select = {
          tab = "extend_parent_node_end";
          S-tab = "extend_parent_node_start";
        };
      };
    };
    ignore = [
      "flake.lock"
      ".gitignore"
      "result"
      "Cargo.lock"
    ];
  };

}

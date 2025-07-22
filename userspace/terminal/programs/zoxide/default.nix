{
  programs.zoxide = {
    enable = true;
  };

  environment.shellInit = # bash
    ''
      function __zoxide_zih() {
        \builtin local result
        result="$(\command zoxide query -i -- $@)" && __zoxide_cd "$result"
        _direnv_hook
        hx .
      }
      function __zoxide_zh() {
        __zoxide_z "$1"
        _direnv_hook
        hx .
      }

      function __file_clipboard_copy() {
        wl-copy -t text/uri-list file:/"$1"
      }

      alias zh=__zoxide_zh
      alias zih=__zoxide_zih
      alias cf=__file_clipboard_copy
    '';
}

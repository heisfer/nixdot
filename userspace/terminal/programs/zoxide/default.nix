{
  programs.zoxide = {
    enable = true;
  };

  environment.shellInit = ''
    function __zoxide_zih() {
      \builtin local result
      result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "$result"
      _direnv_hook
      hx .
    }
    function __zoxide_zh() {
      __zoxide_z "$@"
      _direnv_hook
      hx .
    }

    alias zh=__zoxide_zh
    alias zih=__zoxide_zih
  '';
}

{
  inputs,
  pkgs,
  ...
}: {
  programs.xplr = {
    enable = true;
    extraConfig =
    ''
    local home = os.getenv("HOME")
    package.path = home
    .. "/.config/xplr/plugins/?/init.lua;"
    .. home
    .. "/.config/xplr/plugins/?.lua;"
    .. package.path
    xplr.config.modes.builtin.default.key_bindings.on_key["e"] =
      xplr.config.modes.builtin.action.key_bindings.on_key["e"]
    '';
  };
}

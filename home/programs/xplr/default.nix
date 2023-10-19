{
  inputs,
  pkgs,
  ...
}: {
  programs.xplr = {
    enable = true;
    extraConfig =
    ''
    xplr.config.modes.builtin.default.key_bindings.on_key["e"] =
      xplr.config.modes.builtin.action.key_bindings.on_key["e"]
    '';
  };
}
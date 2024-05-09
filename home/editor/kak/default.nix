{ inputs, pkgs, ... }:
{
  home.file = {
    rose-pine = {
      target = ".config/kak/colors/rose-pine.kak";
      source = "${inputs.kak-rose-pine}/colors/rose-pine.kak";
    };
  };
  programs.kakoune = {
    enable = true;
    config = {
      hooks = [
        {
          name = "ModuleLoaded";
          option = "powerline";
          commands = "powerline-enable; powerline-start";
        }
        {
          name = "ModuleLoaded";
          option = "smarttab";
          commands = "set-option global softtabstop 4
          set-option global smarttab_expandtab_mode_name = 'exp'";
        }
      ];
      colorScheme = "rose-pine";
    };
    plugins = with pkgs.kakounePlugins; [
      auto-pairs-kak
      kakoune-lsp
      smarttab-kak
      powerline-kak
    ];
  };
}

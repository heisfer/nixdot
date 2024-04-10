{inputs,pkgs, ...}: {
  home.packages = with pkgs; [
    inputs.heisfer-nixvim.packages.${pkgs.system}.default
    prismlauncher
    tutanota-desktop
    qdigidoc
    devenv
    xdg-utils
    telegram-desktop
  ];
}

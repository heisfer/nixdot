{...}: {
  imports = [
    ../editors/helix
    ../default.nix
    ../wayland/hyprland
    ../waybar
    ../mako
    ../rofi
    ../gtk

	#shell stuff
	../shell/bash.nix
	../shell/nushell.nix
	../shell/starship.nix
	../shell/carapace.nix
  ];

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "23.05";
  };
}

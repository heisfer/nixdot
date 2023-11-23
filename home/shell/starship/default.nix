
{ config, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;

	settings = {
      add_newline = true;
      character = { 
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

	};
  };
}

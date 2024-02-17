{inputs, ... }: {
  home.file = {
	  waybar-rose-pine = {
		  target = ".config/waybar/rose-pine.css";
			source = "${inputs.waybar-rose-pine}/rose-pine.css";
		};
	};
  programs.waybar = {
	  enable = true;

		settings = {
		  mainBar = {
				mode = "dock";
				modules-left = [

				];
				modules-center = [
				  "clock"
				];

				modules-right = [
				  "tray"

				];
				
				mpris = {
				  format = "DEFAULT: {player_icon} {dynamic}";
					format-paused = "DEFAULT: {status_icon} <i>{dynamic}</i>";
					player-icons = {
					  default = "▶";
						mpv = "🎵";
					};
					status-icon = {
					  paused = "⏸";
					};
				};
			};
		};


		style = ''
		  @import "./rose-pine.css";
			
		'';

	};
}


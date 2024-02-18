{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
	  swaynotificationcenter
	];

	home.file = {
	  swaync-rose-pine = {
		  target = ".config/swaync";
			source = "${inputs.swaync-rose-pine}/theme";
		};
	};



}

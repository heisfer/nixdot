{
  description = "Heisfer's nixdot";

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [
        ./nixos
        ./nixos/modules
        ./home/modules
        ./pkgs
        ./overlays
      ];

      systems = [ "x86_64-linux" ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/nur";

    waybar-rose-pine.url = "github:rose-pine/waybar";
    waybar-rose-pine.flake = false;
    swaync-rose-pine.url = "github:rose-pine/swaync";
    swaync-rose-pine.flake = false;
    alacritty-rose-pine.url = "github:rose-pine/alacritty";
    alacritty-rose-pine.flake = false;

    helix.url = "github:helix-editor/helix";
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:heisfer/Wallpapers";
      flake = false;
    };

    rose-pine-rofi = {
      url = "github:heisfer/rose-pine-rofi";
      flake = false;
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm-nightly = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

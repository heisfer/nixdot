{
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

  nix-darwin.url = "github:nix-darwin/nix-darwin/master";
  nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  nix-index-database.url = "github:nix-community/nix-index-database";
  nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  hjem = {
    url = "github:feel-co/hjem";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # OWN STYLES
  rofi-rose-pine = {
    url = "github:heisfer/rose-pine-rofi";
    flake = false;
  };

  swaync-rose-pine = {
    url = "github:rose-pine/swaync";
    flake = false;
  };

  wallpapers = {
    url = "github:heisfer/Wallpapers";
    flake = false;
  };

  # MASTER BRANCH / CACHIX
  hyprland.url = "github:hyprwm/hyprland";
  hyprsunset = {
    url = "github:hyprwm/hyprsunset";
    inputs = {
      nixpkgs.follows = "hyprland/nixpkgs";
      systems.follows = "hyprland/systems";
      hyprutils.follows = "hyprland/hyprutils";
      hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
      hyprland-protocols.follows = "hyprland/hyprland-protocols";
    };
  };
  # helix-master.url = "github:helix-editor/helix";
  helix-master.url = "github:heisfer/helix/patchy";
  wezterm-master.url = "github:wezterm/wezterm?dir=nix";
  lightly = {
    url = "github:Bali10050/Darkly";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  prismlauncher = {
    url = "github:PrismLauncher/PrismLauncher";
  };

  lix = {
    url = "git+https://git.lix.systems/lix-project/lix.git";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  lix-module = {
    url = "git+https://git.lix.systems/lix-project/nixos-module.git";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.lix.follows = "lix";
  };

  nix-minecraft.url = "github:heisfer/nix-minecraft/geyser";

  nixtheplanet.url = "github:matthewcroughan/nixtheplanet";

}

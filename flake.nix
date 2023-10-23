{
  description = "thinkchan";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:helix-editor/helix";
    
    rycee-nurpkgs = {
      url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
      inputs.nixpkgs.follows = "nixpkgs";
    };


    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurpkgs.url = github:nix-community/NUR;
  };
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays { inherit inputs system; };
      };
      extraArgs = {
        inherit (inputs.rycee-nurpkgs.lib.${system}) buildFirefoxXpiAddon;
        addons = pkgs.nur.repos.rycee.firefox-addons;
      };
    in
    {
      nixosConfigurations =
        import ./hosts { inherit inputs system pkgs extraArgs; };
      };
    }

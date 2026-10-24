{
  description = "Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    mitos.url = "github:mitos-editor/mitos";
    pinnacle.url = "github:pinnacle-comp/pinnacle";
    pinnacle.inputs.nixpkgs.follows = "nixpkgs";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    preservation.url = "github:nix-community/preservation";

    #flake-pats
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}

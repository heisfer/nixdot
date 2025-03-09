{ pkgs, ... }:
let
  nixpkgs-modrinth-fix = pkgs.fetchFromGitHub {
    owner = "getchoo-contrib";
    repo = "nixpkgs";
    rev = "45a17797406d7fe86b56cb4f76058fd1193283a5";
    hash = "sha256-RAePo9CE6ZE4Z2yxDgCKvwcWQ35K7kSg10dcNucNL9k=";
  };
  system = pkgs.system;
  pr389902 = import nixpkgs-modrinth-fix {
    inherit system;
    config.allowUnfree = true;
  };
in
{

  environment.systemPackages = [
    (pr389902.modrinth-app.override {
      jdks = with pkgs; [
        temurin-jre-bin-21
        temurin-jre-bin-8
        temurin-jre-bin-17
      ];
    })
  ];
}

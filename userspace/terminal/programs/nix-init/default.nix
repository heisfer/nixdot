{
  programs.nix-init = {
    enable = true;
    settings = {
      maintainers = [ "heisfer" ];
      nixpkgs = "<nixpkgs>";
    };
  };
}

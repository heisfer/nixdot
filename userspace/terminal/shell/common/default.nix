{
  environment.shellAliases = {
    ll = "ls -l";
    lla = "ls -la";
    nft = "nix flake new -t $@";
    nt = "sudo nixos-rebuild test --fast";
    nto = "sudo nixos-rebuild test --offline --fast";
    ns = "sudo nixos-rebuild switch";
  };
}

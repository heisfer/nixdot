{
  imports = [
    ./helix
    ./rofi.nix
  ];
  hjem = {
    users.heisfer = {
      enable = true;
      directory = "/home/heisfer";
      user = "heisfer";
    };
    # So that files change after rebuild
    clobberByDefault = true;
  };
}

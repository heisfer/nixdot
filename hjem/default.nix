{
  imports = [
    ./helix
  ];
  hjem = {
    users.heisfer = {
      enable = true;
      directory = "/home/heisfer";
      user = "heisfer";
    };
  };
}

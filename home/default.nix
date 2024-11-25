{ ylib, ... }:
{
  imports = ylib.umport {
    paths = [
      ./terminal
      ./programs
    ];
    recursive = true;
  };

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "24.11";
  };
}

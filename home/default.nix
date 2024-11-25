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
  };
  home.stateVersion = "24.11";
}

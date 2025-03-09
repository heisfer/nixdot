{
  # hjem = {
  #   users.heisfer = {
  #     enable = true;
  #     directory = "/home/heisfer";
  #     user = "heisfer";
  #   };
  #   # So that files change after rebuild
  #   clobberByDefault = true;
  # };
  shitfest = {
    enable = true;
    users = [ "heisfer" ];
    clobberByDefault = true;
  };
}

{
  programs.git = {
    enable = true;
    userName = "heisfer";
    userEmail = "heisfer@aol.com";
    ignores = [
      ".direnv"
      ".envrc"
    ];
  };
  programs.gh = {
    enable = true;
  };
}

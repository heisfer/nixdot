{
  programs.git = {
    enable = true;
    userName = "heisfer";
    userEmail = "heisfer@refract.dev";
    ignores = [
      ".direnv"
      ".envrc"
    ];
  };
  programs.gh = {
    enable = true;
  };
}

{pkgs, ...}: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userEmail = "heisfer@refract.dev";
    userName = "heisfer";
    ignores = ["*result*" ".direnv" "node_modules"];
  };
  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
}

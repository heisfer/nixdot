{
  programs.direnv = {
    enable = true;
    silent = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # hjem for all users
    config = {
      whitelist = {
        prefix = [
          "~/Projects/php"

        ];
      };

    };
  };
}

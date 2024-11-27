{
  programs.nushell = {
    enable = true;
    configFile.text = # nushell
      ''
        $env.config = {
          show_banner: false
        }
      '';
  };
}

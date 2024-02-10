{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden
  ];
  programs.rbw = {
    enable = true;
  };
}

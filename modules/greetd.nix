{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # theme packages
    rose-pine-gtk-theme
    bibata-cursors
  ];

  programs.regreet = {
    enable = true;

    # cageArgs = ["-s" "-m" "last"];

    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Bibata-Modern-Classic";
        icon_theme_name = "Adwaita";
        theme_name = "rose-pine";
      };
    };
  };
  services.greetd.enable = true;
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}

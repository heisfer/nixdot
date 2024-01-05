{
  pkgs,
  inputs,
  ...
}: {
  users.extraUsers.greeter = {
    packages = with pkgs; [
      inputs.self.packages.${pkgs.system}.rose-pine-gtk
      bibata-cursors
    ];
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  programs.regreet = {
    enable = true;

    cageArgs = ["-s" "-m" "last"];

    settings = {
      background = {
        path = ./wallpaper.jpg;
        fit = "Cover";
      };
      GTK = {
        # application_prefer_dark_theme = true;
        cursor_theme_name = "Bibata-Modern-Classic";
        icon_theme_name = "Adwaita";
        theme_name = "RosePine-Main-B-LB";
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

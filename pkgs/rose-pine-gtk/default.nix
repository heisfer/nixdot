{
  stdenvNoCC,
  fetchFromGitHub,
  gnome-themes-extra,
  gtk-engine-murrine,
}:
stdenvNoCC.mkDerivation rec {
  pname = "rose-pine-gtk-theme";
  version = "unstable-2023-07-22";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Rose-Pine-GTK-Theme";
    rev = "95aa1f2b2cc30495b1fc5b614dc555b3eef0e27d";
    sha256 = "I9UnEhXdJ+HSMFE6R+PRNN3PT6ZAAzqdtdQNQWt7o4Y=";
  };

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  buildInputs = [ gnome-themes-extra ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    mkdir -p $out/share/icons
    cp -a themes/* $out/share/themes
    cp -a icons/* $out/share/icons
    runHook postInstall
  '';

  # meta = with lib; {
  #   description = "A Gtk theme based on the Gruvbox colour pallete";
  #   homepage = "https://www.pling.com/p/1681313/";
  #   license = licenses.gpl3Only;
  #   platforms = platforms.unix;
  #   maintainers = [ maintainers.math-42 ];
  # };
}

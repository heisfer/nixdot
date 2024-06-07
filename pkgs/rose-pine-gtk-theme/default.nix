{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gnome-themes-extra,
  gtk-engine-murrine,
}:
stdenvNoCC.mkDerivation {
  pname = "rose-pine-gtk-theme";
  version = "0-unstable-2023-02-20";

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

  meta = {
    description = "A GTK theme with the Rosé Pine colour palette. ";
    homepage = "https://www.pling.com/p/1810530 ";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ heisfer ];
  };
}

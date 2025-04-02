{
  stdenvNoCC,
  fetchFromGitHub,
  gtk-engine-murrine,
  sassc,
  gnome-themes-extra,
}:
stdenvNoCC.mkDerivation {
  pname = "rose-pine-gtk-theme";
  version = "0-unstable-2024-11-06";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Rose-Pine-GTK-Theme";
    rev = "037a1d22e27e99fccce2064a30e4a086b60fbe67";
    sha256 = "sha256-nEp9qHVfGMzO6QqkYk1NJ5FT+h0m/bnkrJUzAskNUac=";
  };

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  nativeBuildInputs = [ sassc ];

  buildInputs = [ gnome-themes-extra ];

  dontBuild = true;

  postPatch = ''
    patchShebangs themes/install.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cd themes
    ./install.sh -n Rose-Pine -d "$out/share/themes"

    runHook postInstall
  '';
}

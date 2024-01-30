{
  fetchurl,
  appimageTools,
}: let
  name = "miru";
  version = "4.5.10";
  src = fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v${version}/linux-Miru-${version}.AppImage";
    hash = "sha256-ptaviLwr0X/MuF517YLW7i9+rtnktcpgHVqMHn+tXWg=";
  };
  appimageContents = appimageTools.extractType2 {inherit name src;};
in
  appimageTools.wrapType2 {
    inherit name src;

    extraInstallCommands = ''

      # Installs .desktop files
      install -Dm444 ${appimageContents}/${name}.desktop -t $out/share/applications
      install -Dm444 ${appimageContents}/${name}.png -t $out/share/pixmaps
      substituteInPlace $out/share/applications/${name}.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name}'
    '';
  }

{ fetchurl
, appimageTools
, lib
}:
let
  name = "miru";
  src = fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v4.4.11/linux-Miru-4.4.11.AppImage";
    sha256 = "sha256-/2R19+jjAfAjfbG4IqzdulV55tzB3QoT/LAw1a2bE38=";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    
    # Installs .desktop files
    install -Dm444 ${appimageContents}/${name}.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/${name}.png -t $out/share/pixmaps
    substituteInPlace $out/share/applications/${name}.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name}'
  '';
  
}

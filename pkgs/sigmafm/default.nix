{ fetchurl
, appimageTools
}:
let
  name = "sigma-file-manager";
  version = "1.7.0";
  src = fetchurl {
    url = "https://github.com/aleksey-hoffman/sigma-file-manager/releases/download/v${version}/Sigma-File-Manager-${version}-Linux-Debian.AppImage";
    hash = "sha256-UZK45HvPrnomdhQe76ntKWNuF+fkyOCVhU4WAyjMxY4=";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
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

{ appimageTools, fetchurl, lib }:

let
  pname = "station";
  version = "2.5.0";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/getstation/desktop-app/releases/download/v${version}/Station-x86_64.AppImage";
    sha256 = "cv25EXFxIHhZb6raKBNdLq1srWN4BZYIXQ9cGzLuTBw=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in appimageTools.wrapType2 rec {
  inherit name src;

  profile = ''
    export LC_ALL=C.UTF-8
  '';

  multiArch = false;
  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  extraInstallCommands = ''
    mv $out/bin/{${name},${pname}}
    install -m 444 -D ${appimageContents}/station-desktop-app.desktop $out/share/applications/station-desktop-app.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/station-desktop-app.png \
      $out/share/icons/hicolor/512x512/apps/station-desktop-app.png
    substituteInPlace $out/share/applications/station-desktop-app.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "A single place for all of your web applications";
    homepage = "https://getstation.com";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}

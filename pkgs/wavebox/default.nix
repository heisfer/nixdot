{ alsa-lib
, autoPatchelfHook
, fetchurl
, gtk3
, gtk4
, libnotify
, copyDesktopItems
, makeDesktopItem
, makeWrapper
, mesa
, nss
, lib
, libdrm
, qt6
, stdenv
, udev
, xdg-utils
, xorg
}:

stdenv.mkDerivation rec {
  pname = "wavebox";
  version = "10.118.5-2";

  src = fetchurl {
    url = "https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz";
    sha256 = "sha256-TxMl8pdycCMY6NFi5MSLZg0p/+KmuAPQOm370bPMm/0=";
  };

  # don't remove runtime deps
  dontPatchELF = true;
  # ignore optional Qt 5 shim
  autoPatchelfIgnoreMissingDeps = [ "libQt5Widgets.so.5" "libQt5Gui.so.5" "libQt5Core.so.5" ];

  nativeBuildInputs = [ autoPatchelfHook makeWrapper qt6.wrapQtAppsHook copyDesktopItems ];

  buildInputs = with xorg; [
    libXdmcp
    libXScrnSaver
    libXtst
    libxshmfence
    libXdamage
  ] ++ [
    alsa-lib
    gtk3
    nss
    libdrm
    mesa
    gtk4
    qt6.qtbase
  ];

  runtimeDependencies = [ (lib.getLib udev) libnotify gtk4 ];

  desktopItems = [
    (makeDesktopItem rec {
      name = "Wavebox";
      exec = "wavebox --enable-features=UseOzonePlatform --ozone-platform=wayland";
      icon = "wavebox";
      desktopName = name;
      genericName = name;
      categories = [ "Network" "WebBrowser" ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/opt/wavebox
    cp -r * $out/opt/wavebox

    # provide icon for desktop item
    mkdir -p $out/share/icons/hicolor/128x128/apps
    ln -s $out/opt/wavebox/product_logo_128.png $out/share/icons/hicolor/128x128/apps/wavebox.png

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper $out/opt/wavebox/wavebox-launcher $out/bin/wavebox \
    --prefix PATH : ${xdg-utils}/bin
  '';

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "Wavebox messaging application";
    homepage = "https://wavebox.io";
    license = licenses.mpl20;
    maintainers = with maintainers; [ rawkode ];
    platforms = [ "x86_64-linux" ];
    hydraPlatforms = [ ];
  };
}

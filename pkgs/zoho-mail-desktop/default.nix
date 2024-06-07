{
  # lib,
  appimageTools,
  fetchurl,
}:
let
  pname = "zoho-mail-desktop";
  version = "1.6.1";

  src = fetchurl {
    urls = [
      "https://downloads.zohocdn.com/zmail-desktop/linux/zoho-mail-desktop-lite-x64-v1.6.1.AppImage"
      # Fallback url. Upstream doesn't store older versions of the software 
      "https://web.archive.org/web/20240601212439/https://downloads.zohocdn.com/zmail-desktop/linux/zoho-mail-desktop-lite-x64-v1.6.1.AppImage"
    ];
    hash = "sha256-dXl46ELcuQS4e9geNPUV0hB+LKOru9q5oCc8ar3/9Mo=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [ pkgs.xorg.libxkbfile ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zoho-mail-desktop.desktop $out/share/applications/zoho-mail-desktop-lite.desktop

    substituteInPlace $out/share/applications/zoho-mail-desktop-lite.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=zoho-mail-desktop' \

    for size in 16 32 64 128 256 512 1024; do
      install -Dm444 ${appimageContents}/usr/share/icons/hicolor/''${size}x''${size}/apps/zoho-mail-desktop.png \
        -t $out/share/icons/hicolor/''${size}x''${size}/apps/
    done
  '';
}

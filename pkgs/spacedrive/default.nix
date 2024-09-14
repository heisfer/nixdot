{
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,

  # additional stuff
  libsoup,
  gdk-pixbuf,
  glib,
  webkitgtk_4_1,
  xdotool,

  gst_all_1,
}:

stdenv.mkDerivation {
  pname = "spacedrive";
  version = "0.3.1";

  src = fetchurl {
    url = "https://github.com/spacedriveapp/spacedrive/releases/download/0.3.1/Spacedrive-linux-x86_64.deb";
    hash = "sha256-E1mOODG4YzBc0TPZJmKgrt/c5hp5LwzLaYPl+J5dnkg=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  # Depends: libc6, libxdo3, libwebkit2gtk-4.1-0, libgtk-3-0
  # Recommends: gstreamer1.0-plugins-ugly
  # Suggests: gstreamer1.0-plugins-bad
  buildInputs = [
    xdotool
    glib
    libsoup
    webkitgtk_4_1
    gdk-pixbuf

    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin

    cp -r usr/share $out/
    cp -r usr/lib $out/
    cp -r usr/bin $out/

    runHook postInstall
  '';
}

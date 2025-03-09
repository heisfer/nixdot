{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  #Build Inputs
  juce,
  freetype,
  alsa-lib,
  xorg,
  pkgs,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "zlequalizer";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "ZL-Audio";
    repo = "ZLEqualizer";
    tag = finalAttrs.version;
    hash = "sha256-H9jHheOojzAxaEPG5+XxejauBXLmYQunNJkmrkMEoXM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    juce
    freetype
    pkgs.webkitgtk_4_1
    pkgs.libGLU
    pkgs.libglvnd # Dunno if it's needed?
    alsa-lib
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
  ];

  cmakeFlags = [
    "VST3"
    "Standalone"
    "LV2"
    (lib.cmakeBool "BUILD_JUCE_PLUGIN" true)
    (lib.cmakeBool "USE_JUCE_PROGRAMS" true)
    # "-DYSFX_PLUGIN_COPY=OFF"
    # "-DYSFX_PLUGIN_USE_SYSTEM_JUCE=ON"
  ];

  cmakeBuildType = "Release";

})

{
  lib,
  fetchFromGitHub,
  fetchurl,
  rustPlatform,
  cmake,
  ninja,
  wrapGAppsHook4,
  glib-networking,
  gst_all_1,
  libsysprof-capture,
  libayatana-appindicator,
  nodejs,
  openssl,
  pkg-config,
  yq-go,
  pnpm_9,
  webkitgtk_4_1,
  cargo-tauri,
  desktop-file-utils,
}:

let
  webkitgtk_4_1' = webkitgtk_4_1.override {
    enableExperimental = true;
  };

  shelter = fetchurl {
    url = "https://raw.githubusercontent.com/uwu/shelter-builds/818204a0a78c07ccaed6552cc9522da9c2b82e2a/shelter.js";
    hash = "sha256-yhYE710nZQjTNr1No3d40wTP8D+Zj22s37wBWgk4TF0=";
    meta = {
      homepage = "https://github.com/uwu/shelter";
      sourceProvenance = [ lib.sourceTypes.binaryBytecode ]; # actually, minified JS
      license = lib.licenses.cc0;
    };
  };
in

# nyo finalAttrs :<
# https://github.com/NixOS/nixpkgs/pull/194475
rustPlatform.buildRustPackage rec {
  pname = "dorion";
  version = "0-unstable-2025-02-27";

  src = fetchFromGitHub {
    owner = "SpikeHD";
    repo = "Dorion";
    rev = "26c534a118aeace4cde4db5447a460ebcba5d6ba";
    hash = "sha256-EetRPa2v2UBav+UwprG7TgcswNzbjfBMvP4xlYOnWYI=";
  };

  cargoPatches = [
    ./no-cargo-patch.patch
  ];

  cargoRoot = "src-tauri";
  buildAndTestSubdir = cargoRoot;

  useFetchCargoVendor = true;
  cargoHash = "sha256-+AVmg/fyIsyksOoGwphePdd+9VtklTO1SFWlM+FBgbE=";

  pnpmDeps = pnpm_9.fetchDeps {
    inherit pname version src;
    hash = "sha256-xBonUzA4+1zbViEsKap6CaG6ZRldW1LjNYIB+FmVRFs=";
  };

  # CMake (webkit extension)
  cmakeDir = ".";
  cmakeBuildDir = "src-tauri/extension_webkit";
  dontUseCmakeConfigure = true;
  dontUseNinjaBuild = true;
  dontUseNinjaCheck = true;
  dontUseNinjaInstall = true;
  # cmake's supposed to set this automatically
  # ... but the detection is based on the presence of ninja build hook
  cmakeFlags = [
    "-GNinja"
  ];

  nativeBuildInputs = [
    pnpm_9.configHook
    cargo-tauri.hook
    nodejs
    pkg-config
    wrapGAppsHook4
    yq-go
    desktop-file-utils
    cmake
    ninja
  ];

  buildInputs = [
    openssl
    webkitgtk_4_1'
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-rs
    glib-networking
    libsysprof-capture
    libayatana-appindicator
  ];

  postPatch = ''
    # remove updater
    rm -rf updater

    # patch cargo-deps
    pushd $cargoDepsCopy/tauri-plugin-shell-*
    patch -p1 < /build/source/src-tauri/patches/tauri-plugin-shell+*.patch
    popd

    substituteInPlace $cargoDepsCopy/libappindicator-sys-*/src/lib.rs \
      --replace-fail "libayatana-appindicator3.so.1" "${libayatana-appindicator}/lib/libayatana-appindicator3.so.1"

    # disable pre-build script and disable auto-updater
    yq -iPo=json '
      .bundle.resources = (.bundle.resources | map(select(. != "updater*")))
    ' src-tauri/tauri.conf.json

    # link shelter injection
    ln -s ${shelter} src-tauri/injection/shelter.js

    # link html/frontend data
    ln -s /build/source/src /build/source/src-tauri/html
  '';

  configurePhase = ''
    cmakeConfigurePhase
    pnpmConfigHook
  '';

  buildPhase = ''
    ninjaBuildPhase
    cd /build/source
    tauriBuildHook
  '';

  postInstall = ''
    # Set up the resource directories
    mkdir -p $out/lib/Dorion
    ln -s $out/lib/Dorion $out/lib/dorion
    rm -rf $out/lib/Dorion/injection
    cp -r src-tauri/injection $out/lib/Dorion
    cp -r src $out/lib/Dorion

    # Modify the desktop file
    desktop-file-edit \
      --set-comment "Tiny alternative Discord client" \
      --set-key="Exec" --set-value="Dorion %U" \
      --set-key="TryExec" --set-value="Dorion" \
      --set-key="StartupWMClass" --set-value="Dorion" \
      --set-key="StartupNotify" --set-value="true" \
      --set-key="Categories" --set-value="Network;InstantMessaging;Chat;" \
      --set-key="Keywords" --set-value="dorion;discord;vencord;chat;im;vc;ds;dc;dsc;tauri;" \
      --set-key="Terminal" --set-value="false" \
      --set-key="MimeType" --set-value="x-scheme-handler/discord" \
      $out/share/applications/Dorion.desktop
  '';

  # error: failed to run custom build command for `Dorion v6.4.1 (/build/source/src-tauri)`
  # Permission denied (os error 13)
  doCheck = false;

  env = {
    TAURI_RESOURCE_DIR = "${placeholder "out"}/lib";
  };

  meta = {
    homepage = "https://spikehd.github.io/projects/dorion/";
    description = "Tiny alternative Discord client";
    longDescription = ''
      Dorion is an alternative Discord client aimed towards lower-spec or
      storage-sensitive PCs that supports themes, plugins, and more!
    '';
    changelog = "https://github.com/SpikeHD/Dorion/releases/tag/v${version}";
    downloadPage = "https://github.com/SpikeHD/Dorion/releases/tag/v${version}";
    license = with lib.licenses; [
      gpl3Only
      cc0 # Shelter
    ];
    mainProgram = "Dorion";
    maintainers = with lib.maintainers; [
      nyabinary
      aleksana
      griffi-gh
      getchoo
    ];
    platforms = lib.platforms.linux;
    sourceProvenance = [
      lib.sourceTypes.binaryBytecode # actually, minified JS
      lib.sourceTypes.fromSource
    ];
  };
}

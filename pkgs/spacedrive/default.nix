{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook,
  atk,
  cairo,
  dbus,
  gdk-pixbuf,
  glib,
  gtk3,
  libsoup_3,
  openssl,
  pango,
  sqlite,
  vulkan-loader,
  webkitgtk,
  stdenv,
  darwin,
  wayland,
}:

rustPlatform.buildRustPackage rec {
  pname = "spacedrive";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "spacedriveapp";
    repo = "spacedrive";
    rev = version;
    hash = "sha256-EqQowMujaKUHTEj2TKnOPwggGZvnYmcV9/PBDH7Q01E=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "builtin-psl-connectors-0.1.0" = "sha256-+byV/gI1eLdIewpFoCnrGAL3TgtDAVGoVly9atAKwk8=";
      "drag-2.0.0" = "sha256-LMtTCvRk/UaWPr4hp+x0sFsyhEOocwORpAhl9RjewUI=";
      "graphql-parser-0.3.0" = "sha256-0ZAsj2mW6fCLhwTETucjbu4rPNzfbNiHu2wVTBlTNe4=";
      "httpz-0.0.6" = "sha256-rB6Vi40LfYxHi759IyIOFAH7qAoE38wuPyYit+VTpX4=";
      "if-watch-3.2.0" = "sha256-N5kFEA26KAlgV6yRBqYUfKDXzHnHqIejfBLZJs4ViJE=";
      "libp2p-0.54.1" = "sha256-R2mtuGUR+6LhQw8o4SUMCi/ojHC7V/W42NkYcr/QFqg=";
      "notify-6.1.1" = "sha256-bwJNllVzv5zoxUIk/4ogWBM6qSCtxjlHWeO3MKKU6Pk=";
      "pdfium-render-0.8.25" = "sha256-6gmPM7fdxhoREZxFvatg8Fvtu+OZSKhPOvSEt6FFrMA=";
      "prisma-client-rust-0.6.8" = "sha256-Gg5+EVexdyR85KQ0CiUSsl809MvkvAxkdx+IsWhNhqs=";
      "sd-cloud-schema-0.1.0" = "sha256-m64WWUm60+3XmgaSad9If6ss25WxYg7EiszkSFZ1tsc=";
      "specta-datatype-from-0.0.1" = "sha256-m5KMEwd9re0nUlbNGX90ulbd2rNO5GYjee+nd+0vTds=";
      "tauri-specta-2.0.0-rc.20" = "sha256-mMFmGYr+2vLGnvUfw6ip+r9S2Dq0YeXmxyF81PWLAZ4=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    wrapGAppsHook
  ];

  buildInputs = [
    atk
    cairo
    dbus
    gdk-pixbuf
    glib
    gtk3
    libsoup_3
    openssl
    pango
    sqlite
    vulkan-loader
    webkitgtk
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.CoreGraphics
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.IOKit
    darwin.apple_sdk.frameworks.Metal
    darwin.apple_sdk.frameworks.QuartzCore
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = {
    description = "Spacedrive is an open source cross-platform file explorer, powered by a virtual distributed filesystem written in Rust";
    homepage = "https://github.com/spacedriveapp/spacedrive";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "spacedrive";
  };
}

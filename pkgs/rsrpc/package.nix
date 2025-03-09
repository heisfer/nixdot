{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  pkg-config,
  pkgs,
}:
rustPlatform.buildRustPackage {
  pname = "rsrpc";
  version = "0-unstable-2025-01-10";

  src = fetchFromGitHub {
    owner = "SpikeHD";
    repo = "rsRPC";
    rev = "7d3dce42961b9d8a37b06743eb82440ee8ed60db";
    hash = "sha256-Ht/0q9fpl55V0B3zCBWS0nuEU7nFJfmmYRbucALr0rM=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-hJMZYGc2SD7dt5o20nwTuAdyblfXryKuduIkjcJNA0E=";

  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    openssl
  ];

  OPENSSL_LIB_DIR = "${lib.getLib openssl}/lib";
  OPENSSL_DIR = "${lib.getDev openssl}";
  OPENSSL_NO_VENDOR = 1;

  meta = {
    description = "Rust implementation ";
    homepage = "https://github.com/euclio/mdpls";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "rsrpc-cli";
  };
}

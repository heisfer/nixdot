{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libgit2,
  openssl,
  zlib,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "code2prompt";
  version = "3.0.2";

  src = fetchFromGitHub {
    owner = "mufeedvh";
    repo = "code2prompt";
    rev = "v${finalAttrs.version}";
    hash = "sha256-9YbsrbExRFbsEz2GifklmUGp3YlsEUOi25+P5vPK8fs=";
  };

  cargoHash = "sha256-cAaGQ28bMLoBzzcTpltiMmFlSimcm3xwiS1+MbRp37s=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    [
      libgit2
      openssl
      zlib
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.Security
    ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = {
    description = "A CLI tool to convert your codebase into a single LLM prompt with source tree, prompt templating, and token counting";
    homepage = "https://github.com/mufeedvh/code2prompt";
    changelog = "https://github.com/mufeedvh/code2prompt/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "code2prompt";
  };
})

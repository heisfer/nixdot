{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "0-unstable-2024-06-04";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "485c56b8187573a53fe5558371b4c4b64fb62cfa";
    hash = "sha256-wNLlUng309UF1CwIzRnYgTFyhpJotfto63G3C1mDlfA=";
  };

  cargoHash = "sha256-skVQLsohMkWzVIGMt4d3YbMXYElEwZ9EhgtzLtp4pJA=";

  meta = {
    description = "Word completion and snippets LSP for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "simple-completion-language-server";
  };
}

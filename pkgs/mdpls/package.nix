{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "mdpls";
  version = "0-unstable-2022-07-23";

  src = fetchFromGitHub {
    owner = "euclio";
    repo = "mdpls";
    rev = "30761508593d85b5743ae39c4209947740eec92d";
    hash = "sha256-4n1MX8hS7JmKzaL8GfMq2q3IdwE4fvMmWOYo7rY+cdY=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = {
    description = "Markdown Preview Language Server";
    homepage = "https://github.com/euclio/mdpls";
    # license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "mdpls";
  };
}

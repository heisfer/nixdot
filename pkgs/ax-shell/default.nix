{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "ax-shell";
  version = "0-unstable-2025-04-07";

  src = fetchFromGitHub {
    owner = "Axenide";
    repo = "Ax-Shell";
    rev = "9ea8b98f57fe373d5a8ec3f2ff1e367d8c5758de";
    hash = "sha256-G54G/awdl1VJ1N+kLRkUuP0UqD3x23QAjp7tvRFrT0M=";
  };

  meta = {
    description = "A hackable shell for Hyprland, powered by Fabric";
    homepage = "https://github.com/Axenide/Ax-Shell";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "ax-shell";
    platforms = lib.platforms.all;
  };
}

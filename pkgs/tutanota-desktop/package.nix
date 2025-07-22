{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {

  pname = "tutanota-desktop";
  version = "299.250715.0";

  src = fetchFromGitHub {
    owner = "tutao";
    repo = "tutanota";
    tag = "tutanota-release-${finalAttrs.version}";
    fetchSubmodules = true;
    hash = "sha256-30VpgnEbcXIQkNzJo76LpP3eKImZfribfI5mHW/xLyQ=";
  };

  npmDepsHash = "sha256-dRIOTB3y7h0MTuKWQlJoCNlatohg7nn3OOMvee5V/yg=";

})

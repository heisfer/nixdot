{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  electron,
  removeReferencesTo,
  nodejs,
  srcOnly,

  copyDesktopItems,
}:
buildNpmPackage (finalAttrs: {
  pname = "tutanota";
  version = "277.250414.1";

  src = fetchFromGitHub {
    owner = "tutao";
    repo = "tutanota";
    tag = "tutanota-release-${finalAttrs.version}";
    hash = "sha256-HoGlGtbbqFp1U2hpfBXAy4GthvWjsHQDVHXqhSwUsQc=";
    fetchSubmodules = true;
  };

  npmDepsHash = "";

  preBuild = ''
    for f in $(find -path '*/node_modules/better-sqlite3' -type d); do
       echo "hello" \
      (cd "$f" && (
      npm run build-release --offline --nodedir="${srcOnly nodejs}"
      find build -type f -exec \
        ${lib.getExe removeReferencesTo} \
        -t "${srcOnly nodejs}" {} \;
      ))
    done
  '';
  nativeBuildInputs = [

    electron
    copyDesktopItems
  ];
  env.ELECTRON_SKIP_BINARY_DOWNLOAD = 1;

})

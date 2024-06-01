{
  mkYarnPackage,
  fetchFromGitHub,
  fetchYarnDeps,
}:

mkYarnPackage rec {
  pname = "blade-formatter";
  version = "f52c7f29bc273a046084ee95beffde36be0d57fb";

  src = fetchFromGitHub {
    owner = "shufo";
    repo = pname;
    rev = "${version}";
    hash = "sha256-zW/dNB/IR9J9A0nSTxB06ekMzsBoFszHFgndOAcYIVI=";
  };

  packageJSON = ./package.json;
  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-D4V8fW2lzOHR7gQBNTzHk3dta1Xs6VF6ONjRpkLHk7k=";
  };

  postBuild = "yarn build";
}

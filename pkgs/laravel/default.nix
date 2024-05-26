{ php, fetchFromGitHub, ... }:
php.buildComposerProject (finalAttrs: {
  pname = "laravel";
  version = "5.8.1";

  src = fetchFromGitHub {
    owner = "laravel";
    repo = "installer";
    rev = "v${finalAttrs.version}";
    hash = "sha256-LQABZnmKgJ8qkymmSjhjc+x1qZ/tFqFyQbfeGZECxok=";
  };

  composerLock = ./composer.lock;
  vendorHash = "sha256-f18N2qNCUFetCaHaC4X6Benq70x21SVQ3YSs8kovK1g=";
})

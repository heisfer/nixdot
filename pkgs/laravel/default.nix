{ php, fetchFromGitHub, ... }:
php.buildComposerProject (finalAttrs: {
  pname = "laravel";
  version = "5.8.0";

  src = fetchFromGitHub {
    owner = "laravel";
    repo = "installer";
    rev = "v${finalAttrs.version}";
    hash = "sha256-faOmvuHrdAd3BCW/14OPEPSXiaGHDxiFdVOoG2uE6ss=";
  };

  composerLock = ./composer.lock;
  vendorHash = "sha256-edmRUNpMHeoTP6KM0wYXVbhawpYRIa0H/0LXjpzDLFU=";
})

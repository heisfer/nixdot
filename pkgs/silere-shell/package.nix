{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
  quickshell,
  bash,
  coreutils,
  findutils,
  gnugrep,
  gnused,
  gawk,
  fontconfig,
  procps,
  systemd,
  networkmanager,
  wireplumber,
  brightnessctl,
  upower,
  libnotify,
}:
stdenvNoCC.mkDerivation {
  pname = "silere-shell";
  version = "1.4.3";
  src = fetchFromGitHub {
    owner = "s3rven";
    repo = "silere-shell";
    tag = "v1.4.3";
    hash = "sha256-r/3tshGLbu+SMcz0wQuyActCTEmdahkhIstB9t6nhAg=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/silere-shell $out/bin
    cp -r shell.qml release.json config modules services scripts assets security $out/share/silere-shell/
    chmod +x $out/share/silere-shell/scripts/silere
    makeWrapper $out/share/silere-shell/scripts/silere $out/bin/silere \
      --prefix PATH : ${
        lib.makeBinPath [
          quickshell
          bash
          coreutils
          findutils
          gnugrep
          gnused
          gawk
          fontconfig
          procps
          systemd
          networkmanager
          wireplumber
          brightnessctl
          upower
          libnotify
        ]
      }
    runHook postInstall
  '';
  meta = {
    description = "Minimal desktop shell for Niri and Hyprland";
    homepage = "https://github.com/s3rven/silere-shell";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "silere";
  };
}

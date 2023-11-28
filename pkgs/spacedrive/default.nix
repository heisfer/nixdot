{ fetchurl
, appimageTools
,
}:
let
  name = "spacedrive";
  version = "0.1.4";
  src = fetchurl {
    url = "https://github.com/spacedriveapp/spacedrive/releases/download/${version}/Spacedrive-linux-x86_64.AppImage";
    sha256 = "sha256-iBdW8iPuvztP0L5xLyVs7/K8yFe7kD7QwdTuKJLhB+c=";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;

  extraPkgs = pkgs:
    (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
    ++ [ pkgs.libthai ];

  extraInstallCommands = ''

      # Installs .desktop files
      install -Dm444 ${appimageContents}/${name}.desktop -t $out/share/applications
      install -Dm444 ${appimageContents}/${name}.png -t $out/share/pixmaps
      substituteInPlace $out/share/applications/${name}.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name}'
    '';
}

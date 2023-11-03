
{ stdenv
, dpkg
, glibc
, gcc-unwrapped
, autoPatchelfHook
}:
let
  pname = "sidekick";
  version = "116.53.1.36301-d58457f";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://cdn.meetsidekick.com/browser-builds/sidekick-linux-release-x64-${version}.deb";
    sha256 = "";
  };
in stdenv.mkDerivation {
  inherit name src;

  system = "x86_64-linux";

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp -av $out/opt/meetsidekick.com/sidekick/* $out
    rm -rf $out/opt
  '';

  meta = with stdenv.lib; {
    description = "Wolframscript";
    homepage = https://www.wolfram.com/wolframscript/;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}

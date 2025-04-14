{ lib }:
let
  inherit (lib.meta) getExe getExe';
  loadNixFiles =
    dir:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        if type == "directory" then
          loadNixFiles (dir + "/${name}")
        else if name == "default.nix" then
          dir + "/${name}"
        else
          [ ]
      ) (builtins.readDir dir)
    );
in
{
  uwsmGetExe = package: "uwsm-app -- " + getExe package;
  uwsmGetExe' = package: bin: "uwsm-app -- " + getExe' package bin;
  loadNixFiles = dir: loadNixFiles dir;
}

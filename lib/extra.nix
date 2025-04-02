{ lib }:
let
  inherit (lib.meta) getExe getExe';
  loadNixFiles =
    dir:
    lib.mapAttrs (
      name: type:
      if type == "directory" then
        { path = dir; } ++ loadNixFiles (dir + "/${name}")
      else if name == "default.nix" then
        { meh = false; }
      else
        { fdsa = false; }
    ) (builtins.readDir dir);
in
{
  uwsmGetExe = package: "uwsm-app -- " + getExe package;
  uwsmGetExe' = package: bin: "uwsm-app -- " + getExe' package bin;
  loadNixFiles = dir: loadNixFiles dir;
}

{ lib }:
let
  inherit (lib.meta) getExe getExe';
in
{
  uwsmGetExe = package: "uwsm-app -- " + getExe package;
  uwsmGetExe' = package: bin: "uwsm-app -- " + getExe' package bin;
}

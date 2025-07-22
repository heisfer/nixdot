{ config, lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool listOf str;
in
{

  options.dafuck.internal = mkOption {
    type = bool;
    readOnly = true;
  };

  options.dafuck.public = mkOption {
    type = listOf str;
    default = [ ];
  };

  config = {
    dafuck.internal = config.dafuck.public == [ ];
  };

}

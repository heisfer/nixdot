{ lib }:
let
  inherit (lib.types)
    oneOf
    bool
    int
    float
    str
    path
    attrsOf
    listOf
    nullOr
    ;
  hyprlang = nullOr (oneOf [
    bool
    int
    float
    str
    path
    (attrsOf hyprlang)
    (listOf hyprlang)
  ]);
in
{
  inherit hyprlang;
}

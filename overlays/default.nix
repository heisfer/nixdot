{ inputs, system, ... }:

with inputs;

let
in
[
  nurpkgs.overlay
  inputs.helix.overlays.default
]

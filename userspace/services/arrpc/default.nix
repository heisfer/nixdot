{ pkgs, ... }:
{
  services.arrpc = {
    enable = false;
    package = pkgs.local.rsrpc;
  };
}

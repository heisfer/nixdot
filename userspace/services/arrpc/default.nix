{ pkgs, ... }:
{
  services.arrpc = {
    enable = true;
    package = pkgs.local.rsrpc;
  };
}

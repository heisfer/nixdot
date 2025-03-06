{ pkgs, ... }:
{
  #if you first time use it then use "boot" instead of "switch"
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    abrmd.enable = true;
  };
}

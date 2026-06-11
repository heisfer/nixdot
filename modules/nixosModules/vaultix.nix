{ inputs, ... }:
{
  flake.nixosModules.vaultix = {

    imports = [ inputs.vaultix.nixosModules.default ];

    vaultix = {
      settings = {
        hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGTOXrN1SDGNIOMpl17yvIBDCgoeCxuI0NdpdLjvCgz";
      };
    };
  };
}

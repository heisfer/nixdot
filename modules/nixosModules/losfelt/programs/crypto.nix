{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;

      cfg = config.losfelt.programs.cryptoshit;
    in
    {
      options.losfelt.programs.cryptoshit.enable = mkEnableOption "crypto stuff";

      config = mkIf cfg.enable {
        environment.systemPackages = [ pkgs.monero-gui ];
        services.xmrig = {
          enable = false;
          settings = {
            autosave = true;
            cpu = true;
            url = "://supportxmr.com"; # Replace with your preferred pool or p2pool address
            user = "YOUR_MONERO_WALLET_ADDRESS";
            pass = "nixos-rig";
            tls = true;
          };
        };

        # Optional: Enable huge pages for better CPU hashrate
        boot.kernel.sysctl = {
          "vm.nr_hugepages" = 128;
        };
      };
    };
}

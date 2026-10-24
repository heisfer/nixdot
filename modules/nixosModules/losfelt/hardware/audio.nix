{
  flake.nixosModules.losfelt =
    { lib, config, ... }:
    let
      inherit (lib) mkEnableOption mkOption mkIf;
      inherit (lib.types) enum;
      cfg = config.losfelt.hardware.audio;
    in
    {
      options.losfelt.hardware.audio = {
        enable = mkEnableOption "Audio";
        engine = mkOption {
          type = enum [
            "pipewire"
            "pulseaudio"
          ];
          default = "pipewire";
        };
      };

      config = lib.mkIf config.losfelt.hardware.audio.enable {
        services.pipewire = mkIf (cfg.engine == "pipewire") {
          enable = true;
          pulse.enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
        };

        services.pulseaudio = mkIf (cfg.engine == "pulseaudio") {
          enable = cfg.engine == "pulseaudio";
          support32Bit = true;
        };

        security.rtkit.enable = true;
      };
    };
}

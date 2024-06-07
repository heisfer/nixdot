{ inputs, ... }:
{
  services.swaync = {
    enable = true;
    settings = inputs.swaync-rose-pine + "/theme/config.json";
    style = inputs.swaync-rose-pine + "/theme/style.css";
  };
}

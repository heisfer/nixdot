{ inputs, ... }:
{
  services.swaync = {
    enable = true;
    settings = inputs.swaync-rose-pine + "/theme/config.json";
    style = builtins.readFile (inputs.swaync-rose-pine + "/theme/style.css");
  };
}

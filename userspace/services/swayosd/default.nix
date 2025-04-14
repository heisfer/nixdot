{ inputs, ... }:
{
  # disabledModules = [ "${inputs.nixdot-modules}/nixos/services/swayosd.nix" ];
  services.swayosd = {
    enable = true;
    # style = # css
    #   ''
    #     window#osd {
    #       padding: 12px 20px;
    #       border-radius: 999px;
    #       border: none;
    #       background: alpha(@theme_bg_color, 0.8); }
    #       window#osd #container {
    #         margin: 16px; }
    #       window#osd image,
    #       window#osd label {
    #         color: @theme_fg_color; }
    #       window#osd progressbar:disabled,
    #       window#osd image:disabled {
    #         opacity: 0.5; }
    #       window#osd progressbar {
    #         min-height: 6px;
    #         border-radius: 999px;
    #         background: transparent;
    #         border: none; }
    #       window#osd trough {
    #         min-height: inherit;
    #         border-radius: inherit;
    #         border: none;
    #         background: alpha(@theme_fg_color, 0.5); }
    #       window#osd progress {
    #         min-height: inherit;
    #         border-radius: inherit;
    #         border: none;
    #         background: @theme_fg_color; }
    #   '';
  };
}

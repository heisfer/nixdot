{
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    inter
    maple-mono-NF
    maple-mono-SC-NF
    ibm-plex
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "BlexMono Nerd Font Propo" ];
      emoji = [ "Noto Emoji" ];
    };
  };
}

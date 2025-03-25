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
    nerd-fonts.symbols-only
    inter
    ibm-plex
  ];
  # ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.maple-mono);
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "IBM Plex Serif"
        "Symbols Nerd Font"
      ];
      sansSerif = [
        "IBM Plex Sans"
        "Symbols Nerd Font"
      ];
      monospace = [
        "IBM Plex Mono"
        "Symbols Nerd Font"
      ];
      emoji = [ "Noto Emoji" ];
    };
  };
}

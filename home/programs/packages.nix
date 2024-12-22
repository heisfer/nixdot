{ pkgs, ... }:
{
  home.packages = with pkgs; [
    itch
    prismlauncher
    runelite
    jetbrains.idea-community
    android-studio-full
    krita
    youtube-music
    discord-canary
  ];
}

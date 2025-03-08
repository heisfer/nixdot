> [!WARNING]  
> Removing Home-manager and moving to nixos/hjem based system. Below README is out-of-date.

# My NixOS Configuration
This flakes configuration is built with `flake-parts`. Currently it's only supporting single hosts.

## File Structure
| Location | Description |
| --- | --- |
| `flake.nix` | Starting Point of Configurations |
| `flake.lock` | Locked versions of inputs |
| `home` | Home Manager Configurations & Modules |
| `nixos` | NixOS Configurations & Modules |
| `pkgs` | Custom Packages |
* overlays are not used

## Made with

* Testing :) It works!
* Helix
  * Post modern editor
* nixfmt-rfc-style
  * Formatting nix code
* deadnix
  * Scans files for dead code 
* wezterm
  * Default terminal

## Screenshot
![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](screenshot.png)

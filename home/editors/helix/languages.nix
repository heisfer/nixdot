{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language-server = {
        intelephense = {
            command = "${pkgs.nodePackages_latest.intelephense}/bin/intelephen";
            args = ["--stdio"];
        };
        nil = {
          command = lib.getExe pkgs.nil;
          config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
        };
    };
    language = [
      {
        name = "php";
        auto-format = true;
        file-types = ["php" "inc"];
        shebangs = ["php"];
        roots = ["composer.json" "index.php"];
        
      }
    ];
  };
}
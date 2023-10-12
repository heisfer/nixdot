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
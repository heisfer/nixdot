{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language-server = {
        phpactor = {
            command = "${pkgs.phpactor}/bin/phpactor";
            args = ["language-server"];
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
        language-servers = [ "phpactor" ];
        roots = ["composer.json" "index.php"];
        
      }
    ];
  };
}

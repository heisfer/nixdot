let
  more = { pkgs, ... }: {
    programs = {
      htop = {
        enable = true;
        settings = {
          sort_direction = true;
          sort_key = "PRESENT_CPU";
        };
      };
    };
  };

in
[
  ./git
]
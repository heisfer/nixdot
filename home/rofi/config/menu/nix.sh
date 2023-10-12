#!/bin/sh


package=$(rofi -dmenu -p "Package search" -l 0 -theme-str 'entry { placeholder: "Package name"; } ') 

search
nixsearch=$(nix search nixpkgs --json $package)
name=$(jq  -r 'keys[] as $k | "\($k)"' <<< ${nixsearch} | cut -d "." -f 3- )
selection=$(echo -e "${name}" | rofi -dmenu -p "Results") 
wl-copy ${selection}
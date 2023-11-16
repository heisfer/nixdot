{config, ... }: let
  
  browser = ["firefox.desktop"];
  video = ["mpv.desktop"];
  image = ["imv.desktop"];

  # XDG MIME types

  associations = {
    "application/x-extension-htm" = browser;
	"appli:cation/x-extension-html" = browser;
	"application/x-extension-shtml" = browser;
	"application/x-extension-xht" = browser;
	"application/x-extension-xhtml" = browser;
	"application/xhtml+xml" = browser;
	"application/json" = browser;
	"application/pdf" = browser;
	"text/html" = browser;
	"x-scheme-handler/about" = browser;
	"x-scheme-handler/chrome" = ["chromium-browser.desktop"];
	"x-scheme-handler/ftp" = browser;
	"x-scheme-handler/http" = browser;
	"x-scheme-handler/https" = browser;
	"x-scheme-handler/unknown" = browser;

	"audio/*" = video;
	"video/*" = video;
	"image/*" = image;
  };
in {
  xdg = {
    enable = true;
	cacheHome= config.home.homeDirectory + "/.local/cache";

	mimeApps = {
	  enable = true;
	  defaultApplications = associations;
	};

	userDirs = {
	 enable = true;
	 createDirectories = true;
	};
  };
}


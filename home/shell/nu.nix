{ ... }:
{
  programs.nushell = {
    enable = true;
	extraConfig = ''
	  $env.config = {
	    show_banner: false,
	    completions: {
	      case_sensitive: false
	      quick: true
	      partial: true
	      algorithm: prefix
	      external: {
	        enable: true
		  }
	    }
	  }
	  $env.EDITOR = hx
	'';
  };
}

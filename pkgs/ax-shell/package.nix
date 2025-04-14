{
  lib,
  fetchFromGitHub,
  python3Packages,
}:
let
  finalAttrs = {
    pname = "ax-shell";
    version = "1.5.1";
    pyproject = false;

    src = fetchFromGitHub {
      owner = "Axenide";
      repo = "Ax-Shell";
      rev = "785ea2ca4dfcf6e838306fa9e3965f19a2047bd3";
      hash = "sha256-K86fCHYbsXrE8IKpe6iC6D6LtegJk4U/O9KFsF0ZVD8=";
    };

    # build-system = with python3Packages; [ setuptools ];

    # It has no tests
    doCheck = false;

    # dependencies = with python3Packages; [
    #   biopython
    #   dendropy
    #   matplotlib
    #   numpy
    #   pandas
    #   seaborn
    #   distutils
    #   requests
    # ];

    # # Minimum needed external tools
    # # See https://github.com/biobakery/phylophlan/wiki#dependencies
    # propagatedBuildInputs = [
    #   raxml
    #   mafft
    #   trimal
    #   blast
    #   diamond
    # ];

    # postInstall = ''
    #   # Not revelant in this context
    #   rm -f $out/bin/phylophlan_write_default_configs.sh
    # '';

    meta = {
      description = "hackable shell for Hyprland, powered by Fabric";
      homepage = "";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ heisfer ];
      # mainProgram = "salib";
    };
  };
in
python3Packages.buildPythonApplication finalAttrs

{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  perSystem = {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs = {
        deadnix.enable = true;
        statix.enable = true;
        nixfmt.enable = true;

        prettier.enable = true;
      };
      settings = {
        global.excludes = [
          "LICENSE"
          ".gitattributes"
          "*.png"
          "*.svg"
        ];
      };
    };
  };
}

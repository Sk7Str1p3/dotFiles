{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShellNoCC {
      name = "Sk7Str1p3";
      env.EDITOR = "lvim";
      packages = with pkgs; [
        yazi
        git
        lunarvim
        nixd
      ];
    };
  };
}

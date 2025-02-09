{
  pkgs,
  inputs,
  lib,
}: {
  firefoxAddons = {
    catppuccin = pkgs.callPackage ./firefoxExt/catppuccin.nix {
      inherit lib;
      inherit (inputs.firefox-addons.lib."x86_64-linux") buildFirefoxXpiAddon;
    };
  };
  millennium = pkgs.callPackage ./millennium/package.nix {
    inherit lib;
    inherit
      (pkgs)
      fetchFromGitHub
      multiStdenv
      asio
      #boxer
      crow
      fmt
      websocketpp
      gnumake
      cmake
      ;
  };
}

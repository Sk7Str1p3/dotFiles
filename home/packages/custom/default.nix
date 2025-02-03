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
  SFP-bin = pkgs.callPackage ./steam/SFP/binary.nix {
    inherit
      (pkgs)
      stdenv
      vistafonts
      zlib
      icu
      openssl
      ;
  };
  SFP = pkgs.callPackage ./steam/SFP/package.nix {
    inherit
      (pkgs)
      buildDotnetModule
      dotnetCorePackages
      stdenv
      zlib
      icu
      openssl
      ;
  };
}

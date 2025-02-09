{
  pkgs,
  inputs,
  lib,
  ...
}: let
  customPkgs = import ./custom {inherit pkgs inputs lib;};
in {
  config = {
    home.packages = with pkgs; [
      adwsteamgtk
      bottles
      wineWow64Packages.stableFull
      #wine-discord-ipc-bridge
      winetricks
      prismlauncher

      customPkgs.millennium
    ];
  };
}

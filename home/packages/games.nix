{
  pkgs,
  inputs,
  lib,
  ...
}: let
  gamePkgs = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
  customPkgs = import ./custom {inherit pkgs inputs lib;};
in {
  config = {
    home.packages = with pkgs; [
      adwsteamgtk
      bottles
      wineWow64Packages.stableFull
      winetricks

      gamePkgs.wine-discord-ipc-bridge

      customPkgs.SFP
    ];
  };
}

{
  pkgs,
  inputs,
  ...
}: let
  gamePkgs = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
in {
  config = {
    home.packages = with pkgs; [
      adwsteamgtk
      bottles
      wineWow64Packages.stableFull
      winetricks

      gamePkgs.wine-discord-ipc-bridge
    ];
  };
}

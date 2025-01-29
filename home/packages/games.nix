{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      steam
      bottles
      wineWow64Packages.stableFull
      winetricks
    ];
  };
}

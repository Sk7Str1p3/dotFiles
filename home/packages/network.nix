{pkgs, ...}: {
  config.home.packages = with pkgs; [
    #vesktop // installed with nixcord module
    arrpc
    transmission_3-gtk
    qbittorrent-enhanced
    samba
    ayugram-desktop
    #firefox // installed with home-manager module
  ];
}

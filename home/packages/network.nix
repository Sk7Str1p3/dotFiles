{pkgs, ...}: {
  config.home.packages = with pkgs; [
    hiddify-app
    nekoray
    vesktop
    arrpc
    transmission_3-gtk
    qbittorrent-enhanced
    samba
    ayugram-desktop
    #firefox # installed with home-manager module
  ];
}

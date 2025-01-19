{pkgs, ...}: {
  config.home.packages = with pkgs; [
    hiddify-app
    nekoray
    vesktop
    arrpc
    transmission_3-gtk
    qbittorrent-enhanced
    samba
  ];
}

{pkgs, ...}: {
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };
    udev.packages = [
      pkgs.gnome-settings-daemon
    ];
  };
}

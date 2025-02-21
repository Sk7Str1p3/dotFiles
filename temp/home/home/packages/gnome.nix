{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nautilus # Files
      gnome-disk-utility # Disks
      gnome-calculator # Calculator
      gnome-calendar # Calendar
      gnome-software # Software
      gnome-logs # Logs
      gnome-connections # Connections
      baobab # Disk usage analyser
      loupe # Photos
      totem # Videos
    ];
  };
}

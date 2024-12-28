{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nautilus
      gnome-disk-utility
      gnome-calculator
      gnome-calendar
      loupe
    ];
  };
}

{
  module = {
    boot = {
      secureBoot.enable = true;
      plymouth.enable = false;
    };

    network = {
      enable = true;
    };

    security = {
      enable = true;
      #enableBootOptions = true;
      #disableIPV6 = true;
      # smth weird happened
    };

    services = {
      gnome.enable = true;
    };

    hardware.sound.enable = true;

    nixos-ng.enable = true;

    virtualisation.libvirtd.enable = true;
  };
}

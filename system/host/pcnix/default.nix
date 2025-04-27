{
  module = {
    system.boot.loader = {
      enable = true;
      type = "systemd-boot";
      isSecured = true;
    };
    boot = {
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

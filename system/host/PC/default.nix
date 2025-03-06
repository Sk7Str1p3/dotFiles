{
  module = {
    boot = {
      secureBoot.enable = true;
      plymouth.enable = false;
    };

    network = {
      enable = true;
    };

    hardware.sound.enable = true;

    nixos-ng.enable = true;

    virtualisation.libvirtd.enable = true;
  };
}

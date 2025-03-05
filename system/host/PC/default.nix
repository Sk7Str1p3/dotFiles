{
  module = {
    boot = {
      secureBoot.enable = true;
      plymouth.enable = false;
    };

    network = {
      enable = true;
    };

    nixos-ng.enable = true;

    virtualisation.libvirtd.enable = true;
  };
}

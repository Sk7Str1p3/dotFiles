{
  module = {
    system.boot.loader = {
      enable = true;
      type = "systemd-boot";
    };

    system.impermanence = {
      enable = true;
    };

    system.network.ssh = {
      enable = true;
      keyAlgorithm = [
        "rsa"
        "ed25519"
        "ecdsa"
      ];
    };
    boot = {
      plymouth.enable = true;
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

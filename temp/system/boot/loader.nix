{lib, ...}: {
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = lib.mkForce false;
        #enable = true;
        configurationLimit = 20;
        consoleMode = "max";
        editor = false;
      };
      timeout = 2;
    };
  };
}

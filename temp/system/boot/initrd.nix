{
  boot.initrd = {
    enable = true;
    checkJournalingFS = true;
    availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "btrfs"
    ];
    includeDefaultModules = true;
    verbose = false;
    systemd = {
      enable = true;
      emergencyAccess = "$y$j9T$vRP8obyn3ByQjDbzVBGkf.$.9MMNi3uhs0UNX/1Jt/H1x9qlBQG8vX9KZE0NxJ3Wv9";
      tpm2.enable = true;
    };
    luks = {
      cryptoModules = [
        "aes"
        "aes_generic"
        "blowfish"
        "twofish"
        "serpent"
        "cbc"
        "xts"
        "lrw"
        "sha1"
        "sha256"
        "sha512"
        "af_alg"
        "algif_skcipher"
      ];
      mitigateDMAAttacks = true;
      devices = {
        NixOS = {
          device = "/dev/disk/by-uuid/db0200f2-fae6-483f-aff1-164cd2d17a0e";
          fallbackToPassword = false;
        };
      };
    };
    systemd = {
      
    };
  };
}

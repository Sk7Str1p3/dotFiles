{
  # TODO: enable disko and set mount points referring to disko config
  fileSystems = {
    "/nix/store" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress-force=zstd"
      ];
    };
    "/" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress-force=zstd"
      ];
    };
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = [
        "defaults"
        "umask=0077"
      ];
    };
    /*
      * "/persist" = {
      *   device = "/dev/mapper/NixOS";
      *   neededForBoot = true;
      *   fsType = "btrfs";
      *   options = [
      *     "subvol=persist"
      *     "compress-force=zstd"
      *   ];
      * };
    */
    "/home" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress-force=zstd"
      ];
    };
    "/.swapvol" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };
  };
}

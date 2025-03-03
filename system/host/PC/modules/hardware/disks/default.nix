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
      options = ["subvol=@swap"];
    };
  };
}

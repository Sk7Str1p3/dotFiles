{
  # TODO: enable disko and set mount points referring to disko config
  fileSystems = {
    "/nix/store" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=nixStore"
        "compress-force=zstd"
      ];
    };
    "/" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress-force=zstd"
      ];
    };
    "/persist" = {
      device = "/dev/mapper/NixOS";
      neededForBoot = true;
      fsType = "btrfs";
      options = [
        "subvol=persist"
        "compress-force=zstd"
      ];
    };
    "/.swapvol" = {
      device = "/dev/mapper/NixOS";
      fsType = "btrfs";
      options = ["subvol=swap"];
    };
  };
}

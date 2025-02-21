{
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "sys_efi";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = [
                  "rw"
                  "relatime"
                  "fmask=0022"
                  "dmask=0022"
                  "codepage=437"
                  "iocharset=ascii"
                  "shortname=mixed"
                  "utf8"
                  "errors=remount-ro"
                ];
              };
            };
            NIX = {
              size = "102400M";
              content = {
                type = "luks";
                name = "1K5_M4!N";
                content = {
                  type = "btrfs";
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                        "discard=async"
                        "space_cache=v2"
                      ];
                      swap = {
                        swapfile.size = "8192M";
                      };
                    };
                  };
                };
              };
            };
            WIN = {
              size = "102400M";
              content = {
                type = "filesystem";
                format = "ntfs";
                mountpoint = "/mnt/Windows";
              };
            };
            PGSp1 = {
              size = "100%";
              content = {
                type = "luks";
                name = "RaidNVME";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "-m raid1 -d raid1"
                    "/dev/mapper/RaidSATA"
                  ];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/mnt/LinuxWare";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
        disk2 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ADATA_SU650_1M1520100693";
          content = {
            type = "gpt";
            partitions = {
              PGSp2 = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "RaidSATA";
                };
              };
            };
          };
        };
        disk3 = {
          type = "disk";
          device = "/dev/sdb";
          content = {
            type = "gpt";
            partitions = {
              HARD = {
                name = "btl_hard";
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ntfs";
                  mountpoint = "/mnt/Hard";
                };
              };
            };
          };
        };
      };
    };
  };
}
#### DETERMINE HARD DRIVE LATER


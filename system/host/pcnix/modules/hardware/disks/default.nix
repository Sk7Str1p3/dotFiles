{
  fileSystems."/nix".neededForBoot = true;
  disko.devices.disk = {
    nvme = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-KINGSTON_SKC3000S1024G_50026B7382BF814E";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
                "umask=0077"
              ];
            };
          };
          nixos = {
            size = "153600M";
            content = {
              type = "luks";
              name = "NixOS";
              content = {
                type = "btrfs";
                extraArgs = [ "f" ];
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                    ];
                  };
                  "store" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                    ];
                  };
                  "swap" = {
                    mountpoint = "/.swapvol";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                    ];
                    swap = {
                      NixSwap.size = "8192M";
                    };
                  };
                };
              };
            };
          };
          raid-volume = {
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
                  "main" = {
                    mountpoint = "/media/LinuxWare";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
    ssd = {
      type = "disk";
      device = "/dev/disk/by-id/ata-ADATA_SU650_1M1520100693";
      content = {
        type = "gpt";
        partitions = {
          raid-volume = {
            size = "100%";
            content = {
              type = "luks";
              name = "RaidSATA";
            };
          };
        };
      };
    };
    hdd = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WDC_WD7500AAKS-00RBA0_WD-WCAPT0571131";
      content = {
        type = "gpt";
        partitions = {
          HDD = {
            size = "100%";
            content = {
              type = "luks";
              name = "HDD";
              content = {
                type = "btrfs";
                extraArgs = [ "f" ];
                subvolumes = {
                  "main" = {
                    mountpoint = "/media/HardDrive";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                      "nofail"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

}
# TODO: add keyfiles settings and add keyfiles into secrets

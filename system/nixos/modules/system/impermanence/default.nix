{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.system.impermanence;
in
{
  options = {
    module.system.impermanence = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Impermanence
        '';
      };
      extraFiles = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = ''
          Extra files which should not be removed on reboot
        '';
      };
      extraDirs = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = ''
          Extra directories which should not be removed on reboot
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.fuse.userAllowOther = true;
    }
    {
      environment.persistence = {
        "/nix/persist/system" = {
          enable = true;
          hideMounts = true;
          directories = [
            "/etc/NetworkManager/system-connections"
            "/var/lib/systemd"
            "/var/lib/nixos"
            "/var/lib/NetworkManager"
          ] ++ cfg.extraDirs;
          files = [
            {
              file = "/etc/sops/keys.txt";
              mode = "0500";
            }
          ] ++ cfg.extraFiles;
        };
      };
    }

    (mkIf (config.fileSystems."/".fsType == "btrfs") {
      boot.initrd.systemd.services.impermanence = {
        description = "Impermanence based on BTRFS subvolumes";
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        wantedBy = [ "initrd.target" ];
        after = [ "systemd-cryptsetup@NixOS.service" ];
        before = [ "sysroot.mount" ];
        script = ''
          mkdir -p /btrfs_tmp
          mount /dev/mapper/NixOS /btrfs_tmp

          if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_old(){
            IFS=$'\n'
            for subvolume in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_old "/btrfs_tmp/$subvolume"
            done
            btrfs subvolume delete "$1"
          }

          for subvolume in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +14); do
            delete_old "$subvolume"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };
    })
  ]);
}

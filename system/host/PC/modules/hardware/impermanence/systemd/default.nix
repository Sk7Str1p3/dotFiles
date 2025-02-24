{
  # SystemD service for impermanence based on btrfs subvolumes
  boot.initrd.systemd.impermanence = {
    description = "Impermanence based on BTRFS subvolumes";
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@NixOS.service"];
    before = ["sysroot.mount"];
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
}

{
  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist/system" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/systemd"
      "/var/lib/nixos"
      "/var/lib/NetworkManager"
    ];
  };
}

{
  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist/host" = {
    enable = false;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager"
      "/var/lib/sbctl"
      "/var/lib/systemd"
      "/var/lib/AccountsService/users"
    ];

    files = [
      "/etc/machine-id"
      "/keys.txt"
    ];
  };
}

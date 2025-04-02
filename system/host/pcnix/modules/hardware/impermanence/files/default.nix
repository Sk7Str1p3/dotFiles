{
  programs.fuse.userAllowOther = true;

  environment.persistence."/persist" = {
    enable = false;
    hideMounts = true;
    directories = [
      "/.rw-etc/upper/NetworkManager"
      "/.rw-etc/upper/resolve.conf"
      "/val/lib/sbctl"
      "/var/lib/systemd"
      "/var/lib"
    ];

    files = [
      "/.rw-etc/machine-id"
    ];
  };
}

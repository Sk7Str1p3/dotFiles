{
  programs.fuse.userAllowOther = true;

  environment.persistence."/persist" = {
    enable = false;
    hideMounts = true;
    # FIXME: which files should be permanent?
  };
}

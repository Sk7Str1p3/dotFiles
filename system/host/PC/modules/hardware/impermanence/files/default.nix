{
  programs.fuse.userAllowOther = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    # FIXME: which files should be permanent?
  };
}

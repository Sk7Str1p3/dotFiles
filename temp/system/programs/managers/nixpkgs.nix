{
  nixpkgs = {
    config = {
      allowAliases = true;
      allowBroken = false;
      allowUnfree = true;
      checkMeta = true;
      cudaSupport = true;
    };
    system = "x86_64-linux";
  };
}

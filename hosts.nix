{
  nixos = {
    pcnix = {
      hostName = "pcnix";
      stateVersion = "25.05";
      defaultBranch = "unstable";
      users = [
        "Sk7Str1p3"
        "Nataly"
      ];
      headless = false;
      hostPlatform = "x86_64-linux";
      hostType = "nixos";
    };
  };
}

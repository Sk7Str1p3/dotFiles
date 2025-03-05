{
  nixos = {
    PC = {
      hostName = "GodlikeNix";
      stateVersion = "24.11";
      defaultBranch = "stable";
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

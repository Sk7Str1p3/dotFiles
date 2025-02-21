{pkgs, ...}: {
  nix = {
    enable = true;
    package = pkgs.nixVersions.latest;

    channel.enable = true;
    gc = {
      automatic = true;
      dates = "22:00";
      options = "--delete-older-than 3d";
      persistent = true;
      randomizedDelaySec = "0";
    };
    optimise = {
      automatic = true;
      persistent = true;
      randomizedDelaySec = "0";
      dates = [
        "06:00"
        "18:00"
        "22:00"
      ];
    };

    settings = {
      allowed-users = [
        "*"
      ];
      auto-optimise-store = true;
      cores = 0;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = 5;
      require-sigs = true;
      sandbox = true;
      show-trace = true;
      substituters = [
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
        "https://lanzaboote.cachix.org/"
        "https://cache.garnix.io/"
        "https://nixos-cache-proxy.cofob.dev/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}

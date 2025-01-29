{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    enable = true;
    package = pkgs.nixVersions.latest;

    channels = {
      nixos = inputs.nixpkgs;
      home-manager = inputs.home-manager;
    };

    checkConfig = true;
    settings = {
      require-sigs = true;
      sandbox = true;
      show-trace = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
        "https://nixos-cache-proxy.cofob.dev/"
        "https://cache.garnix.io/"
        "https://ags.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
      ];
    };
  };
}

{inputs, ...}: {
  nixpkgs.overlays = [
    (self: super: {
      # Stable
      stable = {
        default = import inputs.stable {
          inherit (self) system;
          config = {
            allowBroken = true;
          };
        };
        unfree = import inputs.stable {
          inherit (self) system;
          config = {
            allowBroken = true;
            allowUnfree = true;
          };
        };
      };
      # Unstable
      unstable = {
        default = import inputs.unstable {
          inherit (self) system;
          config = {
            allowBroken = true;
          };
        };
        unfree = import inputs.unstable {
          inherit (self) system;
          config = {
            allowBroken = true;
            allowUnfree = true;
          };
        };
      };
      # Master
      master = {
        default = import inputs.master {
          inherit (self) system;
          config = {
            allowBroken = true;
          };
        };
        unfree = import inputs.master {
          inherit (self) system;
          config = {
            allowBroken = true;
            allowUnfree = true;
          };
        };
      };
    })
  ];
}

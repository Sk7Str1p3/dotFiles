{ inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: _super: {
      # Stable
      stable = import inputs.stable {
        inherit (self) system;
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
      };
      # Unstable
      unstable = import inputs.unstable {
        inherit (self) system;
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
      };
      # Master
      master = import inputs.master {
        inherit (self) system;
        config = {
          allowBroken = true;
          allowUnfree = true;
        };
      };
    })
  ];
}

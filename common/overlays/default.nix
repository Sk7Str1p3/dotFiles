{inputs, ...}: let
  baseSettings = {
    config = {
      allowBroken = true;
    };
  };
  permittedInsecurePackages = [];
  unfreeSettings =
    baseSettings.config
    // {
      inherit permittedInsecurePackages;
      allowUnfree = true;
    };
in {
  nixpkgs.overlays = [
    (self: super: {
      # Stable
      stable = {
        default =
          import inputs.stable {
            inherit (self) system;
          }
          // baseSettings;
        unfree =
          import inputs.stable {
            inherit (self) system;
          }
          // unfreeSettings;
      };
      unstable = {
        default =
          import inputs.unstable {
            inherit (self) system;
          }
          // baseSettings;
        unfree =
          import inputs.unstable {
            inherit (self) system;
          }
          // unfreeSettings;
      };
      master = {
        default =
          import inputs.master {
            inherit (self) system;
          }
          // baseSettings;
        unfree =
          import inputs.master {
            inherit (self) system;
          }
          // unfreeSettings;
      };
    })
  ];
}

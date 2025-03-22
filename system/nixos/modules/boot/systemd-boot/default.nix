{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.boot.systemd-boot;
in
{
  # Declare module options
  options = {
    module.boot.systemd-boot = {
      enable = mkEnableOption "systemd-boot";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    boot = {
      loader = {
        efi = {
          # EFI interaction
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        # Systemd-boot configuration
        systemd-boot = {
          enable = true;
          configurationLimit = 20;
          consoleMode = "max";
          editor = false;
        };
        timeout = 2;
      };
    };
  };
}

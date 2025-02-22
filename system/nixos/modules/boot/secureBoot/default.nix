{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.boot.secureBoot;
in {
  # Declare module options
  options = {
    module.boot.secureBoot = {
      enable = mkEnableOption "lanzaboote";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    # Install sbctl for keys management
    environment.systemPackages = [pkgs.sbctl];

    boot = {
      lanzaboote = {
        # Enable lanzaboote
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
      loader = {
        efi = {
          # EFI interaction
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        # Systemd-boot configuration
        systemd-boot = {
          enable = lib.mkForce false;
          configurationLimit = 20;
          consoleMode = "max";
          editor = false;
        };
        timeout = 2;
      };
    };
  };
}

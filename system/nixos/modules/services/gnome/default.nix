{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.services.gnome;
in {
  options = {
    module.services = {
      gnome.enable = mkEnableOption "Enables gnome services";
    };
  };

  config = mkIf cfg.enable {
    programs.seahorse.enable = true;
    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      gnome = {
        gnome-keyring.enable = true;
        sushi.enable = true;
      };
      udev.packages = [
        pkgs.gnome-settings-daemon
      ];
    };
  };
}

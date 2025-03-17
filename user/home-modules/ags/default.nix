{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.ags;
in {
  # Declare options
  options = {
    module.user.ags = {
      enable = mkEnableOption "ags";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;
      systemd.enable = true;
      configDir = ./configuration;
      extraPackages = with inputs.ags.packages.${pkgs.system}; [
        hyprland
        network
        notifd
        tray
        apps
        mpris
        wireplumber
        cava
      ];
    };
  };
}

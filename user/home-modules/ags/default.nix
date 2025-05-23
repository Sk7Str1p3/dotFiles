{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.ags;
in
{
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
    nix.settings = {
      substituters = [
        "https://ags.cachix.org"
      ];
      trusted-public-keys = [
        "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
      ];
    };
    # keep until #703 is merged
    systemd.user.services.ags.Service.RestartSec = "10";
  };
}

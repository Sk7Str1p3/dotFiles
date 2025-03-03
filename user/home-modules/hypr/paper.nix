{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.hypr.paper;
in {
  # Declare Options
  options = {
    module.user.hypr.paper = {
      enable = mkEnableOption "Hyprpaper";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    services.hyprpaper = {
      package = pkgs.hyprpaper;
      enable = true;
      settings = {
        preload = [
          "${../non-nix/images/purple-sea.jpg}"
        ];
        wallpaper = [
          "HDMI-A-1, ${../non-nix/images/purple-sea.jpg}"
        ];
      };
    };
    #TODO: More wallpapers, switcher script
  };
}

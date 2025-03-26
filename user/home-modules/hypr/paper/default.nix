{
  config,
  lib,
  pkgs,
  self,
  ...
}:
with lib;
let
  cfg = config.module.user.hypr.paper;
in
{
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
          "${self}/assets/wallpapers/purple-sea.png"
        ];
        wallpaper = [
          "HDMI-A-1, ${self}/assets/wallpapers/purple-sea.png"
        ];
      };
    };
    #TODO: More wallpapers, switcher script
  };
}

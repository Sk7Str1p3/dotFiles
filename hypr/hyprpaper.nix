{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.home.homeDirectory}/.config/pictures/wallpaper.jpg"
      ];
      wallpaper = [
        "HDMI-A-1, ${config.home.homeDirectory}/.config/pictures/wallpaper.jpg"
      ];
    };
  };
}

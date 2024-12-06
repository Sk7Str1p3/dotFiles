{
  config,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    package = pkgs.hyprpaper;
    enable = true;
    settings = {
      preload = [
        "${config.home.homeDirectory}/.config/pictures/wallpaper"
      ];
      wallpaper = [
        "HDMI-A-1, ${config.home.homeDirectory}/.config/pictures/wallpaper"
      ];
    };
  };
}

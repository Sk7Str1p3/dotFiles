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
        "${config.home.homeDirectory}/.config/home-manager/non-nix/images/bg-9.png"
      ];
      wallpaper = [
        "HDMI-A-1, ${config.home.homeDirectory}/.config/home-manager/non-nix/images/bg-9.png"
      ];
    };
  };
}

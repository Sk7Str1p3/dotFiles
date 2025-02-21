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
        "${../non-nix/images/purple-sea.jpg}"
      ];
      wallpaper = [
        "HDMI-A-1, ${../non-nix/images/purple-sea.jpg}"
      ];
    };
  };
}

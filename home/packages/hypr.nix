{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      hyprland
      hyprland-protocols
      hyprgui
      hyprpaper
      hypridle
      hyprshot
      hyprpicker
      hyprsunset
      hyprutils
    ];
  };
}

{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      hyprland
      hyprland-protocols
      hyprpaper
      hypridle
      hyprshot
      hyprpicker
      hyprsunset
      hyprutils
    ];
  };
}

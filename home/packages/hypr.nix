{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      hyprland
      hyprland-protocols
      hyprpaper
      #hypridle
      hyprlock
      hyprshot
      hyprpicker
      hyprsunset
      hyprutils
      hyprland-qtutils
    ];
  };
}

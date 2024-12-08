{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      hyprland
      hyprpaper
      hypridle
      hyprshot
      hyprpicker
      hyprsunset
      hyprutils
    ];
  };
}

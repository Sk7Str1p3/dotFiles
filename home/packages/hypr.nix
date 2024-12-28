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
      inputs.hyprland-qtutils.packages."${pkgs.system}".default # Temporary fix, remove then hyprland-qtutils get pushed into nixpkgs
      #hyprpanel
    ];
  };
}

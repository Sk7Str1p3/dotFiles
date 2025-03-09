{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.theme.gtk;
in {
  # Declare options
  options = {
    module.user.theme.gtk = {
      enable = mkEnableOption "gtk";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.magnetic-catppuccin-gtk.override {
          shade = "dark";
          accent = ["purple"];
          size = "standard";
          tweaks = [
            "black"
            "macos"
            "outline"
            "float"
          ];
        };
        name = "Catppuccin-GTK-Purple-Dark";
      };
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Propo";
        size = 12;
      };
      iconTheme = {
        name = "Tela-circle-purple";
        package = pkgs.tela-circle-icon-theme.override {
          colorVariants = ["purple"];
        };
      };
    };
    home.pointerCursor.gtk.enable = true;
  };
}

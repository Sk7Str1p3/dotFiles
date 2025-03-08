{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.rofi;
in {
  # Declare Options
  options = {
    module.user.rofi = {
      enable = mkEnableOption "Visual Studio Code";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "JetBrainsMono Nerd Font Propo 13";
      terminal = "${pkgs.kitty}/bin/kitty";
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Tela-circle-dracula";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
        sidebar-mode = true;
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          blue = mkLiteral "#cba6f7";
          border-col = mkLiteral "#cba6f7";
        };
      };
    };
  };
}

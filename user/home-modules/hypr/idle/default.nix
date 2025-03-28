{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.hypr.idle;
in
{
  # Declare Options
  options = {
    module.user.hypr.idle = {
      enable = mkEnableOption "Hypridle";
    };
  };
  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          /*
            * {
            *   timeout = 150;
            *   on-timeout = "brightnessctl -s set 10";
            *   on-resume = "brightnessctl -r";
            * }
            * {
            *   timeout = 150;
            *   on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            *   on-resume = "brightnessctl -sd rgb:kbd_backlight";
            *  } shit's not gonna work on my hw
          */
          {
            timeout = 330;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 180;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}

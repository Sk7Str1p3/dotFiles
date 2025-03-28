{
  config,
  lib,
  self,
  ...
}:
with lib;
let
  cfg = config.module.user.hypr.lock;
in
{
  # Declare Options
  options = {
    module.user.hypr.lock = {
      enable = mkEnableOption "Hyprlock";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    catppuccin.hyprlock.useDefaultConfig = false;
    programs.hyprlock = {
      enable = true; # Enable Hyprlock - hyprland's session locker
      settings = {
        "$font" = "JetBrainsMono Nerd Font";
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };
        background = {
          path = "${self}/assets/wallpapers/purple-sea.png";
          blur_passes = 3;
        };
        label = [{
          color = "$accent";
          font_family = "$font";
          font_size = 150;
          halign = "center";
          position = "0,170";
          text = "cmd[update:43200000] date +'%H'";
          valign = "center";
        }
        {
          color = "$accent";
          font_family = "$font";
          font_size = 150;
          halign = "center";
          position = "0,0";
          text = "cmd[update:43200000] date +'%M'";
          valign = "center";
        }
        {
          color = "$accent";
          font_family = "$font";
          font_size = 20;
          halign = "center";
          position = "0,-130";
          text = "cmd[update:43200000] date +'%A'";
          valign = "center";
        }
        {
          color = "$accent";
          font_family = "$font";
          font_size = 20;
          halign = "center";
          position = "0,-165";
          text = "cmd[update:43200000] date +'%e %b'";
          valign = "center";
        }
        ];
        input-field = {
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$base";
          font_color = "$accent";
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##$accentAlpha"><i>󰌾 Logged in as </i><span foreground="##$textAlpha">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -230";
          rounding = 20;
          valign = "center";
          halign = "center";
        };
      };
    };
  };
}
#TODO: Recreate lock

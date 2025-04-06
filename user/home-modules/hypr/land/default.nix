{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.hypr.land;
in
{
  # Declare Options
  options = {
    module.user.hypr.land = {
      enable = mkEnableOption "Hyprland";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        "$term" = "${pkgs.kitty}/bin/kitty";
        "$fileManager" = "${pkgs.nautilus}/bin/nautilus";
        "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
        "$cliFM" = "$term -e ${pkgs.yazi}/bin/yazi";

        env = [
          "NIXOS_OZONE_WL, 1"
        ];
        general = {
          gaps_in = 7;
          gaps_out = 30;
          border_size = 3;
          layout = "dwindle";
          "col.active_border" = "rgb(c6a0f6)";
          "col.inactive_border" = "rgba(d8abc270)";
          resize_on_border = false;
          allow_tearing = false;
        };

        decoration = {
          active_opacity = 0.9;
          inactive_opacity = 0.75;
          fullscreen_opacity = 1.0; # opacity of fullscreen
          dim_inactive = true;
          dim_strength = 0.15;
          dim_special = 0.0;
          dim_around = 5.0e-2;
          rounding = 10;
          blur = {
            enabled = true;
            size = 12;
            passes = 2;
            new_optimizations = true;
            xray = false;
            special = true;
            popups = true;
            ignore_opacity = true;
          };
        };

        animations = {
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1,7, myBezier"
            "windowsOut, 1,7, default, popin 80%"
            "border, 1,7, default"
            "borderangle, 1,8, default"
            "fade, 1,7, default"
            "workspaces, 1,7, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:win_space_toggle";
        };

        "$MOD" = "SUPER";
        bind =
          [
            "$MOD, R, exec, $menu"
            "$MOD, return, exec, $term"
            "CTRL ALT, Delete, exit"
            "$MOD, E, exec, $fileManager"
            "$MOD SHIFT, E, exec, $cliFM"
            "$MOD, Q, killactive"
            "$MOD, F, togglefloating"
            "$MOD, P, pseudo"
            "$MOD, J, togglesplit"
            ", Print, exec, ${pkgs.hyprshot}/bin/hyprshot -o ${config.home.homeDirectory}/Pictures/Screenshots -m output -z"
            "SHIFT, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -o ${config.home.homeDirectory}/Pictures/Screenshots -m region -z"

            "$MOD, left, movefocus, l"
            "$MOD, right, movefocus, r"
            "$MOD, up, movefocus, u"
            "$MOD, down, movefocus, d"

            "$MOD, mouse_down, workspace, e+1"
            "$MOD, mouse_up, workspace, e-1"
            "$MOD SHIFT, mouse_down, movetoworkspace, e+1"
            "$MOD SHIFT, mouse_up, movetoworkspace, e-1"
            "$MOD, S, togglespecialworkspace, magic"
            "$MOD SHIFT, S, movetoworkspace, special:magic"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$MOD, code:1${toString i}, workspace, ${toString ws}"
                "$MOD SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          ));
        bindm = [
          "$MOD, mouse:272, movewindow"
          "$MOD, mouse:273, resizewindow"
        ];
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];
        layerrule = [ "blur, AGS" ];
      };
    };
  };
}

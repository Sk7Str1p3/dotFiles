{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      "$rosewater" = "rgb(f5e0dc)";
      "$rosewaterAlpha" = "f5e0dc";

      "$flamingo" = "rgb(f2cdcd)";
      "$flamingoAlpha" = "f2cdcd";

      "$pink" = "rgb(f5c2e7)";
      "$pinkAlpha" = "f5c2e7";

      "$mauve" = "rgb(cba6f7)";
      "$mauveAlpha" = "cba6f7";

      "$red" = "rgb(f38ba8)";
      "$redAlpha" = "f38ba8";

      "$maroon" = "rgb(eba0ac)";
      "$maroonAlpha" = "eba0ac";

      "$peach" = "rgb(fab387)";
      "$peachAlpha" = "fab387";

      "$yellow" = "rgb(f9e2af)";
      "$yellowAlpha" = "f9e2af";

      "$green" = "rgb(a6e3a1)";
      "$greenAlpha" = "a6e3a1";

      "$teal" = "rgb(94e2d5)";
      "$tealAlpha" = "94e2d5";

      "$sky" = "rgb(89dceb)";
      "$skyAlpha" = "89dceb";

      "$sapphire" = "rgb(74c7ec)";
      "$sapphireAlpha" = "74c7ec";

      "$blue" = "rgb(89b4fa)";
      "$blueAlpha" = "89b4fa";

      "$lavender" = "rgb(b4befe)";
      "$lavenderAlpha" = "b4befe";

      "$text" = "rgb(cdd6f4)";
      "$textAlpha" = "cdd6f4";

      "$subtext1" = "rgb(bac2de)";
      "$subtext1Alpha" = "bac2de";

      "$subtext0" = "rgb(a6adc8)";
      "$subtext0Alpha" = "a6adc8";

      "$overlay2" = "rgb(9399b2)";
      "$overlay2Alpha" = "9399b2";

      "$overlay1" = "rgb(7f849c)";
      "$overlay1Alpha" = "7f849c";

      "$overlay0" = "rgb(6c7086)";
      "$overlay0Alpha" = "6c7086";

      "$surface2" = "rgb(585b70)";
      "$surface2Alpha" = "585b70";

      "$surface1" = "rgb(45475a)";
      "$surface1Alpha" = "45475a";

      "$surface0" = "rgb(313244)";
      "$surface0Alpha" = "313244";

      "$surface3" = "rgb(272744)";
      "$surface3Alpha" = "272744";

      "$base" = "rgb(1e1e2e)";
      "$baseAlpha" = "1e1e2e";

      "$mantle" = "rgb(181825)";
      "$mantleAlpha" = "181825";

      "$crust" = "rgb(11111b);";
      "$crustAlpha" = "11111b;";

      "$accent" = "$lavender";
      "$accentAlpha" = "$lavenderAlpha";
      "$font" = "RobotoMonoNerdFont";

      # GENERAL
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
      };

      # BACKGROUND
      background = {
        #monitor =;
        path = "/home/Sk7Str1p3/.config/home-manager/non-nix/images/wallpaper_blur.png";
        #blur_passes = 0;
        #color = "$base";
      };

      # shape = [
      #   {
      #     color = "$surface3";
      #     #outer_color = "$surface0";
      #     size = "70, 50";
      #     position = "130, -195";
      #     halign = "center";
      #     valign = "center";
      #     rounding = 20;
      #   }
      # ];
      #
      label = [
        # {
        #   text = "$LAYOUT[US, RU]";
        #   color = "$overlay1";
        #   font_size = 20;
        #   font_family = "Lato Heavy";
        #   position = "130, -195";
        #   halign = "center";
        #   valign = "center";
        # }
        {
          text = "cmd[update:43200000] echo \"$(date +\"%M\")\"";
          color = "$mauve";
          font_size = 150;
          # font_family = "Lato Heavy";
          font_family = "JetBrainsMono";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(date +\"%H\")\"";
          #text = "cmd[update:43200000] echo \"$(date +\"%H:%M\")\"";
          color = "$mauve";
          font_size = 150;
          #font_family = "Lato Heavy";
          font_family = "JetBrainsMono";
          position = "0, 170";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:43200000] echo \"$(date +\"%A\")\"";
          color = "$lavender";
          font_family = "Lato Semibold";
          font_size = 20;
          #font_family = "RobotoMonoNerdFontMono-SemiBold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:43200000] echo \"$(date +\"%e %b\")\"";
          color = "$lavender";
          font_family = "Lato Semibold";
          font_size = 20;
          #font_family = "RobotoMonoNerdFontMono-SemiBold";
          position = "0, -165";
          halign = "center";
          valign = "center";
        }
      ];

      # USER AVATAR

      #	image = {
      #	    #monitor = ;
      #	    path = "/home/lilac/nix/home-manager/modules/wms/.face";
      #	    size = 160;
      #	    border_color = "$accent";
      #	    position = "0, 75";
      #	    halign = "center";
      #	    valign = "center";
      #	};

      # INPUT FIELD
      input-field = [
        {
          #monitor =
          size = "240, 50";
          outline_thickness = 0;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          rounding = 20;
          outer_color = "$mauve";
          inner_color = "$surface3";
          font_color = "$mauve";
          fade_on_empty = false;
          font_family = "JetBrainsMono";
          #placeholder_text = ''Password...'';
          placeholder_text = ''<span foreground="##$mauveAlpha" font="JetBrainsMono"><b>Passwd::</b></span>'';
          hide_input = false;
          check_color = "$surface0";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -230";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.theme.font;
in
{
  # Declare options
  options = {
    module.user.theme.font = {
      enable = mkEnableOption "font";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font Propo" ];
          emoji = [ "Noto Color Emoji" ];
          sansSerif = [ "JetBrainsMono Nerd Font Propo" ];
          serif = [ "JetBrainsMono Nerd Font Propo" ];
        };
      };
    };
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
    ];
  };
}

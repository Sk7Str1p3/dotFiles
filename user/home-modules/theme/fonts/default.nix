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
          monospace = [ "JetBrainsMono Nerd Font Mono" ];
        };
      };
    };
    home.packages = with pkgs.nerd-fonts; [
      jetbrains-mono
      iosevka
    ];
  };
}

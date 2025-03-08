{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.hypr.cursor;
in {
  # Declare Options
  options = {
    module.user.hypr.cursor = {
      enable = mkEnableOption "HyprCursor";
    };
  };
  config = mkIf cfg.enable {
    home.pointerCursor = {
      hyprcursor = {
        enable = true;
        size = 30;
      };
    };
  };
}

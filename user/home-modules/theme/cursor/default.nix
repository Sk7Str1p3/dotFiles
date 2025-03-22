{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.theme.cursor;
in
{
  # Declare options
  options = {
    module.user.theme.cursor = {
      enable = mkEnableOption "cursor";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    home.pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
    };
  };
}

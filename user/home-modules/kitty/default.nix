{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.user.kitty;
in
{
  # Declare options
  options = {
    module.user.kitty = {
      enable = mkEnableOption "kitty";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font Propo";
        size = 12;
      };
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
  #TODO: More detailed configuration
}

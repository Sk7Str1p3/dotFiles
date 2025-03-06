{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.shell.yazi;
in {
  # Declare Options
  options = {
    module.user.shell.yazi = {
      enable = mkEnableOption "yazi";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
    #TODO: more detailed configuration
  };
}

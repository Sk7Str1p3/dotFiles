{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.shell.direnv;
in {
  # Declare Options
  options = {
    module.user.shell.direnv = {
      enable = mkEnableOption "direnv";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      #enableFishIntegration = true; # r/o value
      mise.enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
  #TODO: more detailed configuration
}

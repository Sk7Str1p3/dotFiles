{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.module.user.shell.eza;
in {
  # Declare Options
  options = {
    module.user.shell.eza = {
      enable = mkEnableOption "eza";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "always";
      icons = "always";
      git = true;
    };
  };
}

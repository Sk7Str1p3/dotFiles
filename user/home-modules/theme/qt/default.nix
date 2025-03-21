{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.module.user.theme.qt;
in {
  # Declare options
  options = {
    module.user.theme.qt = {
      enable = mkEnableOption "qt";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };
  };
}

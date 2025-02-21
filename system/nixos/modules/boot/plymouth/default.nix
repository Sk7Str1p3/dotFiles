{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.boot.plymouth;
in {
  # Declare module options
  options = {
    module.boot.plymouth = {
      enable = mkEnableOption "plymouth";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    boot = {
      # Enable and configure Plymouth
      plymouth = {
        enable = true;
        themePackages = with pkgs; [
          nixos-bgrt-plymouth
          # TODO: custom plymouth theme
        ];
        theme = "bgrt";
      };
      # Add kernel cmdline for proper Plymouth work
      kernelParams = [
        "quiet"
        "splash"
      ];
    };
  };
}

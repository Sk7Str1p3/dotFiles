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
    programs.yazi = mkMerge (attrValues {
      _ = {
        enable = true;
        enableFishIntegration = true;
      };

      # Plugins
      glow = {
        plugins.glow = pkgs.callPackage ./plugins/glow/package.nix {};
        settings.plugin.prepend_previewers = [
          {
            name = "*.md";
            run = "glow";
          }
        ];
      };
      miller = {
        plugins.miller = pkgs.callPackage ./plugins/miller/package.nix {};
        settings.plugin.prepend_previewers = [
          {
            mime = "text/csv";
            run = "miller";
          }
        ];
      };
    });
    #TODO: more detailed configuration
  };
}

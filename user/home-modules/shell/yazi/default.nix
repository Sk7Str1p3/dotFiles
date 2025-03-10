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
      # Plugins
      plugins.mdcat = pkgs.callPackage ./plugins/mdcat/package.nix {};
      settings.plugin.prepend_previewers = [
        {
          name = "*.md";
          run = "mdcat";
        }
      ];
    };
    #TODO: more detailed configuration
  };
}

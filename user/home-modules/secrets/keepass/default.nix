{ config, lib, ... }:
with lib;
let
  cfg = config.module.user.secrets.keepass;
in
{
  options = {
    module.user.secrets.keepass = {
      enable = mkEnableOption ''
        keepass
      '';
      enableBrowserIntegration = mkEnableOption ''
        keepass browser integration
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.keepassxc = {
      enable = true;
      settings = {
        Browser.Enabled = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  self,
  ...
}:
with lib; let
  cfg = config.module.user.hypr.sunset;
in {
  # Declare Options
  options = {
    module.user.hypr.sunset = {
      enable = mkEnableOption "Hyprsunset";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    home.packages = [pkgs.hyprsunset];
    systemd.user.services.hyprsunset = {
      Unit = {
        Description = "Application to enable a blue-light filter on Hyprland";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset --temperature 4500";
        Restart = "on-failure";
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}

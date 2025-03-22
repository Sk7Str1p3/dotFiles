{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.user.shell.nh;
in
{
  # Declare Options
  options = {
    module.user.shell.nh = {
      enable = mkEnableOption "nh";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Documents/dotFiles";
    };
  };
}

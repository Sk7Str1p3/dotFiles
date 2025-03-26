{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.shell.rg;
in
{
  # Declare Options
  options = {
    module.user.shell.rg = {
      enable = mkEnableOption "ripgrep";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      package = pkgs.ripgrep;
      arguments = [ ];
    };
    programs.fish.shellAliases = {
      grep = "${pkgs.ripgrep}/bin/rg";
    };
  };
}

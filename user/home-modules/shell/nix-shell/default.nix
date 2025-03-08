{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.module.user.shell.nix-shell;
in {
  # Declare Options
  options = {
    module.user.shell.nix-shell = {
      enable = mkEnableOption "nix-your-shell";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

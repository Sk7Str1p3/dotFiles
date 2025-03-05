{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.module.common.catppuccin;
in {
  options = {
    module.common.catppuccin = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable catppuccin";
      };
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "mauve";
      # TODO: replace with Stylix
    };
  };
}

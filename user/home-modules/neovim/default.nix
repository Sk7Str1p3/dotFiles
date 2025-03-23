{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.neovim;
in
{
  # Declare Options
  options = {
    module.user.neovim = {
      enable = mkEnableOption "Neovim";
      gui.enable = mkEnableOption "Neovide";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.lunarvim; # TODO: custom nvim config
      viAlias = true;
      vimAlias = true;
    };
    programs.neovide = mkIf cfg.gui.enable {
      enable = true;
      #settings = {...} #TODO: custom neovide settings
    };
  };
}

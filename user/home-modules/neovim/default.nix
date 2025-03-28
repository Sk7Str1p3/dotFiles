{
  config,
  lib,
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
      #package = pkgs.lunarvim; # TODO: custom nvim config
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
    programs.neovide = mkIf cfg.gui.enable {
      enable = true;
      settings = {
        backtraces_path = "${config.home.homeDirectory}/.local/share/neovide";
        fork = true;
        frame = "full";
        idle = true;
        maximized = false;
        mouse-cursor-icon = "arrow";
        #neovim-bin = "${pkgs.lunarvim}/bin/lvim";
        no-multigrid = false;
        srgb = true;
        tabs = true;
        theme = "auto";
        vsync = true;
        wsl = false;
      };
    };
  };
}

{
  lib,
  osConfig,
  config,
  ...
}:
with lib;
let
  cfg = config.module.user.impermanence;
in
{
  options = {
    module.user.impermanence = {
      enable = mkOption {
        type = types.bool;
        default = osConfig.module.system.impermanence.enable;
        description = ''
          Whether to enable Impermanence
        '';
      };
      extraFiles = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = ''
          Extra files which should not be removed on reboot
        '';
      };
      extraDirs = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = ''
          Extra directories which should not be removed on reboot
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.persistence = {
      "/nix/persist/user/${config.home.username}" = {
        enable = true;
        allowOther = true;
        defaultDirectoryMethod = "bindfs";
        directories = [
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
          ".local/share/Steam"
          ".local/share/ElyPrismLauncher"
          ".local/share/AyuGramDesktop"

          ".cargo"

          ".local/share/Trash"
          ".local/share/bottles"
          ".local/share/keyrings"
          ".local/share/direnv"
        ] ++ cfg.extraDirs;
        files = [
          ".local/share/fish/fish_history"
          ".config/onefetch/config.toml"
        ] ++ cfg.extraFiles;
      };
    };
  };
}

{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.user.firefox;
in
{
  # Declare Options
  options = {
    module.user.firefox = {
      enable = mkEnableOption "firefox";
      type = mkOption {
        type = types.enum [
          "firefox"
          "librewolf"
          "floorp"
        ];
        # nix-community/home-manager#6852
        # NixOS/nixpkgs#400250
        #default = "librewolf";
        default = "floorp";
      };
    };
  };
  config = mkIf cfg.enable {
    programs.${cfg.type} = {
      enable = true;

      languagePacks = [
        "en-GB"
        "ru"
      ];
      policies = {
        DefaultDownloadDirectory = "/media/HDD/Downloads";
      };

      profiles.Sk7Str1p3 = {
        bookmarks = {
          force = true;
          settings = [
            { }
          ];
        };

        # TODO: containers = {};

        extensions = [
        ];
      };
    };
  };
}

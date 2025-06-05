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
    };
  };
  config = mkIf cfg.enable {
    programs.firefox = {
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

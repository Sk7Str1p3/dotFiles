{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vesktop;

  #discordPname = cfg.package.pname;
  #discordVersion = cfg.package.version;

  jsonFormat = pkgs.formats.json {};

  /*
    configDir = {
    "discord" = "discord";
    "vesktop" = "vesktop";
  }.${discordPname};
  */
  configDir = "vesktop";

  configBasicFile = "${configDir}/settings.json";
  configAdvFile = "${configDir}/settings/settings.json";
in {
  options.programs.discord = {
    enable = mkEnableOption "Discord";

    settings = {};
  };
}

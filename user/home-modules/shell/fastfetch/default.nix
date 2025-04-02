{
  config,
  lib,
  self,
  ...
}:
with lib;
let
  cfg = config.module.user.shell.fastfetch;
in
{
  # Declare Options
  options = {
    module.user.shell.fastfetch = {
      enable = mkEnableOption "fastfetch";
    };
  };

  #Implementation
  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          padding.left = 1;
          source = "${self}/assets/logo.png";
          height = 8;
        };
        display = {
          separator = " -> ";
          percent.type = 2;
          bar = {
            charElapsed = "|";
            charTotal = "-";
            width = 8;
          };
        };
        modules = [
          {
            type = "title";
            format = "{#magenta}  {#red}{user-name} {#white}on {#blue}{host-name}";
          }
          {
            type = "datetime";
            key = "{#magenta}│  Fetched at";
            format = "{day-pretty}.{month-pretty}.{year}" +
                     " {hour-pretty}:{minute-pretty} {timezone-name}";
          }
          {
            type = "os";
            key = "├ ";
            keyColor = "magenta";
          }
          {
            type = "memory";
            key = "├ ";
            keyColor = "magenta";
          }
          {
            type = "packages";
            key = "├󰏖 ";
            keyColor = "magenta";
          }
          {
            type = "uptime";
            key = "├ ";
            keyColor = "magenta";
          }
          {
            type = "colors";
            key = "╰ ";
            keyColor = "magenta";
            symbol = "circle";
          }
        ];
      };
    };
    programs.fish.interactiveShellInit = ''
      fastfetch
    '';
  };
}

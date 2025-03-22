{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.shell.fish;
in
{
  # Declare Options
  options = {
    module.user.shell.fish = {
      enable = mkEnableOption "fish";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "Done";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "1.19.3";
            hash = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
          };
        }
        /*
          {
            name = "Async";
            src = pkgs.fetchFromGitHub {
              owner = "acomagu";
              repo = "fish-async-prompt";
              rev = "v1.2.0";
              hash = "sha256-B7Ze0a5Zp+5JVsQUOv97mKHh5wiv3ejsDhJMrK7YOx4=";
            };
          }
        */
        {
          name = "Pufferfish";
          src = pkgs.fetchFromGitHub {
            owner = "nickeb96";
            repo = "puffer-fish";
            rev = "12d062eae0ad24f4ec20593be845ac30cd4b5923";
            hash = "sha256-2niYj0NLfmVIQguuGTA7RrPIcorJEPkxhH6Dhcy+6Bk=";
          };
        }
      ];
      functions = {
        fish_greeting = '''';
        yy = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          	builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
    };
  };
}

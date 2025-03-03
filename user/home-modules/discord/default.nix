{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.discord;
in {
  # Declare Options
  options = {
    module.user.discord = {
      enable = mkEnableOption "Discord";
    };
  };

  # Implementarion
  config = mkIf cfg.enable {
    # Enable service for Rich Presence
    services.arrpc.enable = true;

    # Configure Vesktop
    programs.nixcord = {
      enable = true;
      # Disable Discord
      discord.enable = false;

      vesktop = {
        enable = true;
        # Tune Vesktop package
        package = pkgs.vesktop.override {
          withTTS = false;
          withMiddleClickScroll = true;
          withSystemVencord = true;
        };
        # Discord core settings
        settings = {
          "discordBranch" = "ptb";
          "minimizeToTray" = true;
          "arRPC" = false;
          "splashColor" = "rgb(205, 214, 244)";
          "splashBackground" = "rgb(30, 30, 46)";
          "splashTheming" = true;
          "disableMinSize" = true;
          "openLinksWithElectron" = true;
        };
      };
      # Quick CSS ( Theme settings )
      quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css\")";
      vesktopConfig = {
        useQuickCss = true;
        themeLinks = [
          "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
        ];
        # TODO: Add more plugins, including not included by default
        plugins = {
          accountPanelServerProfile.enable = true;
          alwaysAnimate.enable = true;
          alwaysExpandRoles.enable = true;
          betterFonders = {
            enable = true;
          };
          betterRoleContext.enable = true;

          voiceMessages = {
            enable = true;
            noiseSuppression = true;
            echoCancellation = true;
          };
          volumeBooster = {
            enable = true;
            multiplier = 1.5;
          };
          whoReacted.enable = true;

          webKeybinds.enable = true;
          webRichPresence.enable = true;
          webScreenShareFixes.enable = true;
        };
        #TODO: Store password with sops-nix and automatically log in on rebuild
      };
    };
  };
}

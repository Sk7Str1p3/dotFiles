{pkgs, ...}: {
  services.arrpc.enable = true;
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop = {
      enable = true;
      package = pkgs.vesktop.override {
        withTTS = false;
        withMiddleClickScroll = true;
        #withSystemVencord = true;
      };
      settings = {
        "discordBranch" = "ptb";
        "minimizeToTray" = true;
        "arRPC" = true;
        "splashColor" = "rgb(205, 214, 244)";
        "splashBackground" = "rgb(30, 30, 46)";
        "splashTheming" = true;
        "disableMinSize" = true;
        "openLinksWithElectron" = true;
      };
    };
    quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css\")";
    vesktopConfig = {
      useQuickCss = true;
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
      ];
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
    };
  };
}

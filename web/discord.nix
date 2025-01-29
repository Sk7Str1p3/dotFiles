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
        withSystemVencord = true;
      };
    };
    quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css\")";
    vesktopConfig = {
      useQuickCss = true;

      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
      ];
    };
  };
}

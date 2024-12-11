{pkgs, ...}: {
  config = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["JetBrainsMono Nerd Font Mono"];
        };
      };
    };
    home.packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
          "JetBrainsMono"
        ];
      })
    ];
  };
}

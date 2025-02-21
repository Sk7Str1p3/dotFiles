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
    home.packages = with pkgs.nerd-fonts; [
      iosevka
      jetbrains-mono
    ];
  };
}

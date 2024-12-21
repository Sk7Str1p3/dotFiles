{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.magnetic-catppuccin-gtk.override {
        shade = "dark";
        accent = ["purple"];
        size = "standard";
        tweaks = [
          "black"
          "macos"
          "outline"
          "float"
        ];
      };
      name = "Catppuccin-GTK-Purple-Dark";
    };
    font = {
      name = "JetBrainsMono Nerd Font Propo";
      size = 12;
    };
    iconTheme = {
      name = "Tela-circle-dracula";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = ["dracula"];
      };
    };
  };
}

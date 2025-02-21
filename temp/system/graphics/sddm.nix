{pkgs, ...}: {
  config = {
    services.displayManager = {
      # defaultSession = "hyprland";
      sddm = {
        enable = false;
        package = pkgs.kdePackages.sddm;
        wayland = {
          enable = true;
          compositor = "weston";
        };
        theme = "catppuccin-mocha";
      };
    };
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
      banner = "hi <3";
    };
    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "JetBrainsMono Nerd Font Propo";
        fontSize = "12";
        loginBackground = true;
      })
    ];
  };
}

{pkgs, ...}: {
  fonts = {
    packages = with pkgs.nerd-fonts; [
      jetbrains-mono
    ];
    fontconfig = {
      enable = true;
    };
  };
}

{pkgs, ...}: {
  config.home.packages = with pkgs; [
    zsh
    fastfetch
    starship
    tmux
    eza
    yazi
  ];
}

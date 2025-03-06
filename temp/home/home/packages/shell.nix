{pkgs, ...}: {
  config.home.packages = with pkgs; [
    zsh
    fastfetch
    tmux
    eza
    yazi
  ];
}

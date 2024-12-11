{pkgs, ...}: {
  config.home.packages = with pkgs; [
    fish
    zsh
    fastfetch
    starship
    tmux
  ];
}

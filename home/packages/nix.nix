{pkgs, ...}: {
  config.home.packages = with pkgs; [
    manix
    nh
    nix-tree
    nix-output-monitor
    any-nix-shell
  ];
}

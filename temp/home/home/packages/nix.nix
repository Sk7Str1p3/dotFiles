{pkgs, ...}: {
  config.home.packages = with pkgs; [
    nh
    nix-tree
    nix-output-monitor
    any-nix-shell
    direnv
  ];
}

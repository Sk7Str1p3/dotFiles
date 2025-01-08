{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nix-output-monitor
      any-nix-shell
      direnv
    ];
  };
}

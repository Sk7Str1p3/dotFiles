{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nix-output-monitor
      any-nix-shell
      alejandra
      nixd
      direnv
    ];
  };
}

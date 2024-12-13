{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nodejs_latest
    ];
  };
}

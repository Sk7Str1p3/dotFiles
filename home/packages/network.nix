{pkgs, ...}: {
  config.home.packages = with pkgs; [
    hiddify-app
  ];
}

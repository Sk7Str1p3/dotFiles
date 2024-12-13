{
  inputs,
  pkgs,
  ...
}: {
  programs.ags = {
    enable = true;
    configDir = ./non-nix/ags;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      hyprland
      network
      notifd
      apps
      mpris
    ];
  };
}

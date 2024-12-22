{
  inputs,
  pkgs,
  ...
}: {
  programs.ags = {
    enable = true;
    #configDir = ./.;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      hyprland
      network
      notifd
      tray
      apps
      mpris
      wireplumber
      cava
    ];
  };
}

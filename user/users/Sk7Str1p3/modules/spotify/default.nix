{
  config,
  lib,
  pkgs,
  isDarwin,
  inputs,
  ...
}:
with lib;
let
  cfg = config.module.user.spotify;
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify.homeManagerModules.default ];

  options = {
    module.user.spotify = {
      enable = mkEnableOption ''
        Whether to enable Spotify
      '';
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.spicetify = {
        enable = true;
        wayland = !isDarwin;
        windowManagerPatch = !isDarwin;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
        ];
      };
    }

    (mkIf config.module.user.impermanence.enable {
      module.user.impermanence.extraDirs = [
        ".config/spotify"
        ".cache/spotify"
      ];
    })
  ]);
}

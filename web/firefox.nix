{
  pkgs,
  inputs,
  lib,
  ...
}: let
  customPkgs = import ../home/packages/custom {inherit pkgs inputs lib;};
in {
  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-GB"
      "ru"
    ];
    policies = {
      DefaultDownloadDirectory = "/media/HDD/Downloads";
    };

    profiles.Sk7Str1p3 = {
      bookmarks = [
        {}
      ];

      # TODO: containers = {};

      extensions = [
        customPkgs.firefoxAddons.catppuccin
      ];
    };
  };
}

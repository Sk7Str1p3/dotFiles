{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        sops
      ];
    }
    {
      sops.age.keyFile = "/etc/sops/keys.txt";
    }

    (lib.mkIf config.module.user.impermanence.enable {
      module.user.impermanence.extraFiles = [
        ".config/sops/age/keys.txt"
      ];
    })
  ];
}

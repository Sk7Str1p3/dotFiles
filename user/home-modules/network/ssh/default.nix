{
  config,
  lib,
  self,
  ...
}:
with lib;
let
  cfg = config.module.user.network.ssh;
in
{
  options = {
    module.user.network.ssh = {
      enable = mkEnableOption ''
        SSH - Secure Shell
      '';
      keyAlgorithm = mkOption {
        type = types.either (types.listOf (
          types.enum [
            "ecdsa"
            "ed25519"
            "rsa"
          ]
        )) (types.enum [ null ]);
        default = [ "ed25519" ];
        description = ''
          Which types of keys should be unpacked from secrets
          If not "none" keys must be present at secrets/users/{USERNAME}/sshKeys
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.ssh = {
        enable = true;
        addKeysToAgent = "confirm";
        compression = true;
        controlMaster = "yes";
        hashKnownHosts = true;
      };
    }
    {
      services.ssh-agent.enable = true;
    }
    (mkIf (cfg.keyAlgorithm != null) {
      sops.secrets = mkMerge (
        map (algo: {
          "${config.home.username}/sshKeys/${algo}/pub".sopsFile =
            "${self}/secrets/users/${config.home.username}/sshKeys/${algo}.yaml";
          "${config.home.username}/sshKeys/${algo}/key".sopsFile =
            "${self}/secrets/users/${config.home.username}/sshKeys/${algo}.yaml";
        }) cfg.keyAlgorithm
      );
      home.file = mkMerge (
        map (algo: {
          ".ssh/id_${algo}".source =
            config.lib.file.mkOutOfStoreSymlink
              config.sops.secrets."${config.home.username}/sshKeys/${algo}/key".path;
          ".ssh/id_${algo}.pub".source =
            config.lib.file.mkOutOfStoreSymlink
              config.sops.secrets."${config.home.username}/sshKeys/${algo}/pub".path;
        }) cfg.keyAlgorithm
      );
    })
  ]);
}

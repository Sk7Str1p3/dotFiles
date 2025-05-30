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
          "ssh/${algo}/pub" = {
            sopsFile = "${self}/secrets/users/${config.home.username}/sshKeys/${algo}/public.age";
            path = ".ssh/id_${algo}.pub";
          };
          "sshKeys/${algo}/key" = {
            sopsFile = "${self}/secrets/users/${config.home.username}/sshKeys/${algo}/private.age";
            path = ".ssh/id_${algo}";
          };
        }) cfg.keyAlgorithm
      );
    })
  ]);
}

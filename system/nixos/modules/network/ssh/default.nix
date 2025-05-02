{
  lib,
  self,
  config,
  hostName,
  ...
}:
with lib;
let
  cfg = config.module.system.network.ssh;
in
{
  options = {
    module.system.network.ssh = {
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
          If not "none" keys must be present at secrets/hosts/{HOSTNAME}/sshKeys
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
        openFirewall = true;
      };
    }

    (mkIf (cfg.keyAlgorithm != null) {
      sops.secrets = mkMerge (
        map (algo: {
          "ssh/${algo}/pub" = {
            sopsFile = "${self}/secrets/hosts/${hostName}/sshKeys/${algo}.yaml";
            mode = "0444";
          };
          "ssh/${algo}/key".sopsFile = "${self}/secrets/hosts/${hostName}/sshKeys/${algo}.yaml";
        }) cfg.keyAlgorithm
      );
      environment.etc = mkMerge (
        map (algo: {
            "ssh/ssh_host_${algo}_key".source = config.sops.secrets."ssh/${algo}/key".path;
            "ssh/ssh_host_${algo}_key.pub".source = config.sops.secrets."ssh/${algo}/pub".path;
        }) cfg.keyAlgorithm
      );
    })
  ]);
}

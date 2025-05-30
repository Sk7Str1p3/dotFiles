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
          "sshKeys/${algo}/pub" = {
            sopsFile = "${self}/secrets/hosts/${hostName}/sshKeys/${algo}/public.age";
            mode = "0444";
            path = "/etc/ssh/ssh_host_${algo}_key.pub";
          };
          "sshKeys/${algo}/key" = {
            sopsFile = "${self}/secrets/hosts/${hostName}/sshKeys/${algo}/private.age";
            path = "/etc/ssh/ssh_host_${algo}_key";
          };
        }) cfg.keyAlgorithm
      );
    })
  ]);
}

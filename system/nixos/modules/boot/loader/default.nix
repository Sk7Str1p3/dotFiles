{
  lib,
  config,
  self,
  ...
}:
with lib;
let
  cfg = config.module.system.boot.loader;
in
{
  options = {
    module.system.boot.loader = {
      enable = mkEnableOption ''
        OS Bootloader
      '';
      type = mkOption {
        type = types.enum [
          "efistub"
          "systemd-boot"
        ];
        default = "systemd-boot";
        description = ''
          Bootloader type
        '';
      };
      isSecured = mkOption {
        type = types.bool;
        default = false;
        description = ''
          whether to enable Secure Boot
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      boot.loader.efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = config.disko.devices.disk.main.content.partitions.esp.content.mountpoint;
      };
    }

    (mkIf (cfg.type == "systemd-boot") (mkMerge [
      {
        boot.loader.systemd-boot = {
          enable = mkForce (!cfg.isSecured);
          configurationLimit = 20;
          consoleMode = "max";
          editor = false;
        };
        boot.loader.timeout = 3;
      }
      (
        let
          keys = [
            "db"
            "KEK"
            "PK"
          ];
          types = [
            "key"
            "pem"
          ];
        in
        mkIf cfg.isSecured {
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
          sops.secrets = foldl' (acc: sbKey: acc // sbKey) { } (
            builtins.concatMap (
              key:
              map (type: {
                "secureBoot/${key}/${type}" = {
                  sopsFile = "${self}/secrets/hosts/pcnix/sbKeys/${key}.yaml";
                };
                "secureBoot/guid".sopsFile = "${self}/secrets/hosts/pcnix/sbKeys/guid.yaml";
              }) types
            ) keys
          );
          systemd.tmpfiles.settings."11-sbKeys" = foldl' (acc: sbKey: acc // sbKey) { } (
            builtins.concatMap (
              key:
              map (type: {
                "/var/lib/sbctl/keys/${key}/${key}.${type}" = {
                  "L+".argument = config.sops.secrets."secureBoot/${key}/${type}".path;
                };
                "/var/lib/sbctl/GUID"."L+".argument = config.sops.secrets."secureBoot/guid".path;
              }) types
            ) keys
          );
        }
      )
    ]))

    {
      assertions = [
        {
          assertion = cfg.type != "efistub";
          message = "EFISTUB is not implemented yet!";
        }
      ];
    }
  ]);
}

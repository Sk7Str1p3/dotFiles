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

    (mkIf (cfg.type == "systemd-boot") {
      boot.loader.systemd-boot = {
        enable = mkForce (!cfg.isSecured);
        configurationLimit = 20;
        consoleMode = "max";
        editor = false;
      };
      boot.loader.timeout = 0;
      boot.lanzaboote = {
        enable = cfg.isSecured;
        pkiBundle = "/var/lib/sbctl";
      };
    })

    {
      assertions = [
        {
          assertion = cfg.type != "efistub";
          message = "EFISTUB is not implemented yet!";
        }
      ];
    }

    (mkIf cfg.isSecured (
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
      mkMerge (
        builtins.concatMap (
          key:
          map (type: {
            sops.secrets = {
              "secureBoot/${key}/${type}" = {
                sopsFile = "${self}/secrets/hosts/pcnix/sbKeys/${key}/${type}.age";
                path = "/var/lib/sbctl/keys/${key}/${key}.${type}";
              };
              "secureBoot/guid" = {
                sopsFile = "${self}/secrets/hosts/pcnix/sbKeys/guid.age";
                path = "/var/lib/sbctl/GUID";
              };
            };
          }) types
        ) keys
      )
    ))
  ]);
}

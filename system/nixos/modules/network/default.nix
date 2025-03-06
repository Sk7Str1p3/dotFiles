{
  lib,
  config,
  hostName,
  allDirectories,
  ...
}:
with lib; let
  cfg = config.module.network;
in {
  imports = allDirectories ./.;

  # Declare options
  options = {
    module.network = {
      enable = mkEnableOption "network";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    networking = {
      # Basic settings
      inherit hostName;
      useDHCP = mkDefault true;
      # Configure network-manager
      networkmanager = {
        enable = true;
        wifi = {
          backend = "iwd";
          macAddress = "random";
        };
      };
      firewall.checkReversePath = false;
      # Configure IWD as NM backend
      wireless.iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
  };
}

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
    # Enable ResolveD
    services.resolved = {
      enable = true;
    };

    networking = {
      # Basic settings
      inherit hostName;
      useDHCP = true;
      # Configure network-manager
      networkmanager = {
        enable = true;
        wifi = {
          backend = "iwd";
          macAddress = "random";
        };
      };
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

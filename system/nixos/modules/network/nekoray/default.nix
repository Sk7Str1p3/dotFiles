{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.network.nekoray;
in
{
  # Declare options
  options = {
    module.network.nekoray = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable nekoray";
      };
      profiles = mkOption {
        type = types.string;
        default = { };
        description = "Nekoray configuration";
      };
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    # This allow firewall to redirect packets. Required for TUN mode.
    networking.firewall.checkReversePath = config.networking.firewall.enable;

    # Add Nekoray to system packages
  };
}

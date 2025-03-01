{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.module.nixos-ng;
in {
  # Declare options
  options = {
    module.nixos-ng = {
      enable = mkEnableOption "Enable the next-gen NixOS tools";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    # Enable systemd for the initrd
    boot.initrd.systemd.enable = true;

    services = {
      # User manager
      userborn.enable = true;
      # Faster implementation of D-Bus
      dbus.implementation = "broker";
    };

    # Some system tools
    system = {
      switch = {
        enable = false;
        enableNg = true;
      };
      rebuild = {
        enable = false;
        enableNg = true;
      };
    };
  };
  #TODO: find more next-gen tools
}

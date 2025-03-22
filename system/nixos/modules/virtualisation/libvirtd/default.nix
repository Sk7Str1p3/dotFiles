{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.virtualisation.libvirtd;
in
{
  # Declare options
  options = {
    module.virtualisation.libvirtd = {
      enable = mkEnableOption "libvirtd";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    # Enable virtual machines manager
    programs.virt-manager.enable = true;

    # Libvirtd configuration
    virtualisation.libvirtd = {
      enable = true;
      # Configure Qemu/KVM
      qemu = {
        package = pkgs.qemu;
        ovmf = {
          # Firmware configuration
          enable = true;
          packages = with pkgs; [
            OVMFFull.fd
            pkgsCross.aarch64-multiplatform.OVMF.fd
          ];
        };
        runAsRoot = true;
        # Enable TPM support
        swtpm = {
          enable = true;
          package = pkgs.swtpm;
        };
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };
}

{pkgs, ...}: {
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu;
      ovmf = {
        enable = true;
        packages = with pkgs; [
          OVMFFull.fd
          pkgsCross.aarch64-multiplatform.OVMF.fd
        ];
      };
      runAsRoot = true;
      swtpm = {
        enable = true;
        package = pkgs.swtpm;
      };
      vhostUserPackages = [pkgs.virtiofsd];
    };
  };
}

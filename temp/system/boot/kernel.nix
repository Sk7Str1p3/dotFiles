{pkgs, ...}: {
  boot = {
    kernelModules = [
      "kvm-intel"
    ];
    resumeDevice = "/dev/mapper/NixOS";
    kernelParams = [
      "resume_offset=13183565"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

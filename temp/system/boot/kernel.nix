{pkgs, ...}: {
  boot = {
    kernelModules = [
      "kvm-intel"
    ];
    resumeDevice = "/dev/mapper/NixOS";
    kernelParams = [
      "resume_offset=13183565"
      "quiet"
      "splash"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

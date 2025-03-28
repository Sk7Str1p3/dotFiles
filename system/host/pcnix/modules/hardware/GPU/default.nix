{
  pkgs,
  config,
  ...
}:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
      ];
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
    };
  };
}

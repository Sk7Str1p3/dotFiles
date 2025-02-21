{config, ...}: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
  };
}

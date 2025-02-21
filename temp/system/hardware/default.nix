{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware-configuration.nix
    ./nvidia.nix
    ./graphics.nix
    ./cpu.nix
  ];
}

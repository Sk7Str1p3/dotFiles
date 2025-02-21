{
  imports = [
    ./bootspec.nix
    ./crashDump.nix
    ./initrd.nix
    ./kernel.nix
    ./loader.nix
    ./plymouth.nix
  ];

  boot = {
    consoleLogLevel = 4;
    enableContainers = true;
    growPartition = true;
    hardwareScan = true;
  };
}

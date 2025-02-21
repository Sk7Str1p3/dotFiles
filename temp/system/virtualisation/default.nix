{
  imports = [
    ./libvirt.nix
  ];
  virtualisation.spiceUSBRedirection.enable = true;
}

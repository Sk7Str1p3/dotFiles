{
  imports = [
    ./pam.nix
    ./sudo.nix
    ./tpm2.nix
    ./polkit.nix
    ./isolate.nix
    ./apparmor.nix
  ];

  #security.protectKernelImage = true;
}

{
  security.tpm2 = {
    enable = true;
    tssUser = "tss";
    pkcs11.enable = true;
    abrmd.enable = true;
    tctiEnvironment.enable = true;
  };
}

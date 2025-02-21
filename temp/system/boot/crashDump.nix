{
  boot.crashDump = {
    enable = true;
    reservedMemory = "256M";
    kernelParams = [
      "1"
      "boot.shell_on_fail"
    ];
  };
}

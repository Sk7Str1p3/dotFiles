{
  hardware.cpu = {
    intel = {
      updateMicrocode = true;
      sgx = {
        enableDcapCompat = true;
        provision = {
          enable = true;
          group = "sgx";
        };
      };
    };
    x86 = {
      msr = {
        enable = true;
        group = "msr";
        settings.allow-writes = "on";
      };
    };
  };
}

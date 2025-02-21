{
  security.pam = {
    services = {
      SDDM = {
        enableGnomeKeyring = true;
        #startSession = true;
      };
    };
    # sshAgentAuth.enable = true;
    mount = {
      enable = true;
      logoutWait = 100;
      logoutTerm = true;
    };
  };
}

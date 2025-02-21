# _   _      _                      _
#| \ | | ___| |___      _____  _ __| | __
#|  \| |/ _ \ __\ \ /\ / / _ \| '__| |/ /
#| |\  |  __/ |_ \ V  V / (_) | |  |   <
#|_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\
{
  networking = {
    # set hostname
    hostName = "GodlikeNix";
    # configure net daemons with HomeManager, or uncomment ONLY ONE from following:
    # wireless.enable = true;
    /*
       wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
    */
    networkmanager.enable = true;
  };
}

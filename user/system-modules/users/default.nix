{
  users,
  config,
  pkgs,
  lib,
  ...
}:
let
  userList = users ++ [ "root" ];
in
{

  programs.fish.enable = true;

  users.users = lib.foldl' (acc: usr: acc // usr) { } (
    map (user: {
      ${user} = {
        isNormalUser = if (user != "root") then true else false;
        isSystemUser = !config.users.users.${user}.isNormalUser;
        shell = pkgs.fish;
        extraGroups =
          if user != "root" then
            [
              "wheel"
              "networkmanager"
            ]
          else
            [ ];
        hashedPasswordFile = config.sops.secrets."${user}/userPassword".path;
      };
    }) userList
  );
}

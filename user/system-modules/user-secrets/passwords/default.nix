{
  lib,
  users,
  self,
  ...
}:
let
  userList = users ++ [ "root" ];
in
{
  sops.secrets = lib.mkMerge (
    map (user: {
      "${user}/userPassword" = {
        sopsFile = "${self}/secrets/users/${user}/userPassword.yaml";
        neededForUsers = true;
      };
    }) userList
  );
}

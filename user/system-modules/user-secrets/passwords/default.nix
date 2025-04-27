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
  sops.secrets = lib.foldl' (acc: usr: acc // usr) { } (
    map (user: {
      "${user}/userPassword" = {
        sopsFile = "${self}/secrets/users/${user}/userPassword.yaml";
        neededForUsers = true;
      };
    }) userList
  );
}

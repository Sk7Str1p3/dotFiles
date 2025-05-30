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
        sopsFile = "${self}/secrets/users/${user}/userPasswd.age";
        neededForUsers = true;
      };
    }) userList
  );
}

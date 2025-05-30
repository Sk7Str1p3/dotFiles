{
  lib,
  self,
  users,
  ...
}:
{
  sops.secrets = lib.mkMerge (
    map (user: {
      "${user}-face" = {
        sopsFile = "${self}/secrets/users/${user}/face.age";
        mode = "0644";
      };
    }) users
  );
}

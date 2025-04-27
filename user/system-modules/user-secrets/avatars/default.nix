{
  lib,
  self,
  users,
  ...
}:
{
  sops.secrets = lib.foldl' (acc: usr: acc // usr) { } (
    map (user: {
      "${user}-face" = {
        sopsFile = "${self}/secrets/users/${user}/face.png.enc";
        format = "binary";
        mode = "0644";
      };
    }) users
  );
}

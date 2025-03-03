{
  users,
  self,
  ...
}: let
  # add root user in case it didn't appear in users list
  userList = users ++ ["root"];
in {
  imports = map (user: "${self}/user/users/" + user) userList;
}

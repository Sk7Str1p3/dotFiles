{
  headless,
  users,
  lib,
  config,
  pkgs,
  ...
}:
let
  userList = users ++ [ "root" ];
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.hyprland = {
    enable = !headless && !isDarwin && builtins.elem "Sk7Str1p3" userList;
    withUWSM = true;
    xwayland.enable = true;
    systemd.setPath.enable = true;
  };
  services.desktopManager.gnome.enable =
    !headless && !isDarwin && builtins.elem "Nataly" userList;
  services.displayManager.gdm = {
    enable = !headless && !isDarwin;
    wayland = true;
    autoSuspend = true;
  };
  security.pam.services.gdm.enableGnomeKeyring = true;
  systemd.tmpfiles.settings = lib.mkIf (!headless && !isDarwin) {
    "20-gdm-default-session" = lib.mkMerge (
      map (user: {
        "/run/tmpfiles/var/lib/AccountsService/users/${user}".f = {
          argument = ''${lib.generators.toINI { } {
            User = {
              Session = if user == "Sk7Str1p3" then "hyprland-uwsm" else "gnome";
              Icon = config.sops.secrets."${user}-face".path;
              SystemAccount = false;
            };
          }}'';
        };
        "/var/lib/AccountsService/users/${user}"."L+" = {
          argument = "/run/tmpfiles/var/lib/AccountsService/users/${user}";
        };
      }) users
    );
  };
}

{
  users,
  self,
  pkgs,
  lib,
  config,
  inputs,
  hostName,
  homeStateVersion,
  headless,
  allDirectories,
  hostPlatform,
  ...
}:
/*
  Here's some info about user
  to be declared on system level
*/
let
  # add root user in case it didn't appear in users list
  userList = users ++ [ "root" ];
  # detect if nix installed on MacOS
  inherit (pkgs.stdenv) isDarwin;
in
{

  # Passwords (with sops-nix)
  sops.secrets =
    userList
    |> map (user: {
      "${user}/userPassword" = {
        sopsFile = ../secrets/users + "/${user}/userPassword.yaml";
        neededForUsers = true;
      };
    })
    |> lib.foldl (acc: usr: acc // usr) { };

  # Shells
  programs.fish.enable = true;

  # User Settings
  users.users =
    userList
    |> map (user: {
      ${user} = {
        isNormalUser = if (user != "root") then true else false;
        isSystemUser = !config.users.users.${user}.isNormalUser;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
        hashedPasswordFile = config.sops.secrets."${user}/userPassword".path;
      };
    })
    |> lib.foldl (acc: usr: acc // usr) { };

  home-manager = {
    # Home-Manager configuration
    backupFileExtension =
      "backup-"
      + builtins.readFile "${pkgs.runCommandNoCC "timestamp" { }
        "echo -n `date '+%Y%m%d%H%M%S'` > $out"
      }";
    extraSpecialArgs = {
      inherit
        inputs
        self
        hostName
        isDarwin
        homeStateVersion
        headless
        hostPlatform
        allDirectories
        ;
    };

    # Users configuration
    users =
      userList
      |> map (
        user:
        let
          # define $home according to system type
          homeDirectory =
            if (user == "root") then
              "/root"
            else if isDarwin then
              "/Users/${user}"
            else
              "/home/${user}";
        in
        {
          ${user} = {
            imports =
              with inputs;
              [
                impermanence.nixosModules.home-manager.impermanence
                catppuccin.homeManagerModules.catppuccin
                sops.homeManagerModules.sops
                nur.modules.homeManager.default
                nvf.homeManagerModules.default
                nixcord.homeManagerModules.nixcord
                ags.homeManagerModules.default
              ]
              ++ [
                "${self}/user/home-modules"
                "${self}/user/users/${user}/modules"
                "${self}/user/users/${user}/home.nix"
              ]
              ++ [
                "${self}/common/overlays"
                "${self}/common/modules"
              ];

            nixpkgs.overlays = with inputs; [
              nur.overlays.default
              prismLauncher.overlays.default
              nix-vscode-extensions.overlays.default
            ];
            home = {
              inherit homeDirectory;
              stateVersion = homeStateVersion;
            };
          };
        }
      )
      |> lib.foldl (acc: usr: acc // usr) { };
  };

  # Enable desktop environments according to users and system type
  services.xserver.displayManager.gdm = {
    enable = (!headless && !isDarwin);
    wayland = true;
    autoSuspend = true;
  };
  programs.hyprland = {
    enable = (!headless && !isDarwin && builtins.elem "Sk7Str1p3" userList);
    withUWSM = true;
    xwayland.enable = true;
    systemd.setPath.enable = true;
  };
  services.xserver.desktopManager.gnome.enable = (
    !headless && !isDarwin && builtins.elem "Nataly" userList
  );
}

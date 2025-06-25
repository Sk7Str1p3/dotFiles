{
  users,
  self,
  pkgs,
  lib,
  inputs,
  hostName,
  homeStateVersion,
  headless,
  allDirectories,
  hostPlatform,
  ...
}:
let
  userList = users ++ [ "root" ];
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    ./system-modules
  ];

  home-manager = {
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

    users = lib.mkMerge (
      map (user: {
        ${user} = {
          imports =
            with inputs;
            [
              impermanence.nixosModules.home-manager.impermanence
              catppuccin.homeModules.catppuccin
              sops.homeManagerModules.sops
              nur.modules.homeManager.default
              nvf.homeManagerModules.default
              nixcord.homeModules.nixcord
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
            elyprism.overlays.default
            nix-vscode-extensions.overlays.default
          ];
          home = {
            homeDirectory =
              if (user == "root") then
                "/root"
              else if isDarwin then
                "/Users/${user}"
              else
                "/home/${user}";
            stateVersion = homeStateVersion;
          };
        };
      }) userList
    );
  };
}

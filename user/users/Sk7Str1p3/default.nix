{
  self,
  pkgs,
  inputs,
  hostName,
  homeStateVersion,
  headless,
  allDirectories,
  hostPlatform,
  ...
}: let
  # Determine OS to know where to put the home directory
  inherit (pkgs.stdenv) isDarwin;
  homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  username = "Sk7Str1p3";
in {
  # Essential user information which must be declared on system level
  programs.fish.enable = true;
  users.users.Sk7Str1p3 = {
    hashedPassword = "$y$j9T$uWq7PDLmdqjQmf4j8i85v1$cTuvGw3cZFKeUvhD65Mde6fiNuVypgy8cBp/BSBli4D";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };
  # home-manager settings
  home-manager = {
    useUserPackages = true;
    backupFileExtension =
      "backup-"
      + pkgs.lib.readFile
      "${pkgs.runCommandNoCC
        "timestamp" {}
        "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
    extraSpecialArgs = {
      inherit
        inputs
        self
        hostName
        isDarwin
        username
        homeStateVersion
        headless
        hostPlatform
        allDirectories
        ;
    };

    users.${username} = {
      imports = with inputs;
        [
          impermanence.nixosModules.home-manager.impermanence
          catppuccin.homeManagerModules.catppuccin
          sops.homeManagerModules.sops
          nur.modules.homeManager.default
          nixvim.homeManagerModules.nixvim
          nixcord.homeManagerModules.nixcord
          ags.homeManagerModules.default
        ]
        ++ [
          "${self}/user/home-modules"
          "${self}/user/users/${username}/modules"
          "${self}/user/users/${username}/home.nix"
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
  };
}

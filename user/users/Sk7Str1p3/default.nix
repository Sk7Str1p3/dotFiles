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
  users.users.Sk7Str1p3 = {
    hashedPassword = "$y$j9T$uWq7PDLmdqjQmf4j8i85v1$cTuvGw3cZFKeUvhD65Mde6fiNuVypgy8cBp/BSBli4D";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };
  # home-manager settings
  home-manager = {
    useGlobalPkgs = true;
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
          impermanence.nixosSystem.home-manager.impermanence
          sops.homeManagerModules.sops
          nur.modules.homeManager.default
          nixvim.homeManagerModules.nixvim
          nixcord.homeManagerModules.nixcord
          ags.homeManagerModules.default
        ]
        ++ [
          "${self}/common/modules"
          "${self}/user/home-modules"
          "${self}/user/users/${username}/modules"
          "${self}/user/users/${username}/home.nix"
        ];

      nixpkgs.overlays = with inputs; [
        nur.overlay
        prismLauncher.overlays.default
      ];
      home = {
        inherit homeDirectory;
        stateVersion = homeStateVersion;
      };
    };
  };
}

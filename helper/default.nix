{
  self,
  inputs,
  ...
}: let
  # default state version
  defaultStateVersion = "24.11";
  # modules sources
  source = [
    "${self}/user"
    "${self}/system"
    "${self}/secrets"
  ];
  # function to automatically import all directories
  allDirectories = directoryName:
    builtins.filter (
      module: (
        (builtins.pathExists module)
        && ((builtins.readFileType module) == "directory")
      )
    ) (map (
        module: "${directoryName}/${module}"
      ) (builtins.attrNames (
        builtins.readDir directoryName
      )));
  # Function for creating configurations
  mkConfiguration = configurationDir: {
    hostName ? "nixos",
    stateVersion ? defaultStateVersion,
    homeStateVersion ? stateVersion,
    defaultBranch ? "unstable",
    users ? ["user"],
    headless ? false,
    hostPlatform ? "x86_64-linux",
    hostType ? "nixos",
  }:
    inputs.${defaultBranch}.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          configurationDir
          allDirectories
          self
          hostName
          hostType
          headless
          hostPlatform
          stateVersion
          homeStateVersion
          users
          ;
      };
      modules = with inputs;
        [
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          impermanence.nixosModules.impermanence
          nix-flatpak.nixosModules.nix-flatpak
          nur.modules.nixos.default
          sops.nixosModules.sops
        ]
        ++ source;
    };
in {
  forAllSystems = inputs.stable.lib.systems.flakeExposed;

  /*
  * This function just add mkConfiguration before hosts attrset
  * e.g. generic = { username = "test"; stateVersion = "24.11"; }; ->
  * generic = mkHost { username = "test"; stateVersion = "24.11"; };
  */
  mkNixos = builtins.mapAttrs mkConfiguration;
}

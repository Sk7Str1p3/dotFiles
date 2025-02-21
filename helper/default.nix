{
  self,
  inputs,
  ...
}: let
  defaultStateVersion = "24.11";
  source = [
    "${self}/users"
    "${self}/system"
  ];
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
    hostName ? "NixOS",
    stateVersion ? defaultStateVersion,
    defaultBranch ? "unstable",
    users ? ["user"],
    headless ? false,
    hostPlatform ? "x86_64-linux",
    hostType ? "nixos",
  }: let
  in
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
          chaotic.nixosModules.default
          nur.modules.nixos.default
          sops.nixosModules.sops
        ]
        ++ source;
    };
in {
  mkNixos = builtins.mapAttrs mkConfiguration;
  forAllSystems = inputs.stable.lib.systems.flakeExposed;
}

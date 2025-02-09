{
  description = "Sk7Str1p3's home env";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";
    catppuccin.url = "github:catppuccin/nix";
    ags.url = "github:aylur/ags";
    impermanence.url = "github:nix-community/impermanence";

    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    prismLauncher.url = "github:Diegiwg/PrismLauncher-Cracked";
  };

  outputs = {
    nixpkgs,
    nur,
    home-manager,
    nixvim,
    nixcord,
    catppuccin,
    ags,
    impermanence,
    nix-flatpak,
    prismLauncher,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        nur.overlays.default
        prismLauncher.overlays.default
      ];
    };
  in {
    #development shell for home-manager config editing
    devShells.${system}.default = pkgs.mkShell {
      name = "dotFiles";
      packages = with pkgs; [
        alejandra
        nixd
      ];
    };

    # home-manager output
    homeConfigurations."Sk7Str1p3" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
        catppuccin.homeManagerModules.catppuccin
        nixvim.homeManagerModules.nixvim
        nixcord.homeManagerModules.nixcord
        ags.homeManagerModules.default
        impermanence.homeManagerModules.impermanence
        nix-flatpak.homeManagerModules.nix-flatpak
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}

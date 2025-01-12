{
  description = "Sk7Str1p3's home env";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    ayugram.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
    ags.url = "github:aylur/ags";

    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    catppuccin,
    ags,
    nix-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.nur.overlays.default
      ];
    };
  in {
    # home-manager output
    homeConfigurations."Sk7Str1p3" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
        ./home/modules/vesktop.nix
        catppuccin.homeManagerModules.catppuccin
        nixvim.homeManagerModules.nixvim
        ags.homeManagerModules.default
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

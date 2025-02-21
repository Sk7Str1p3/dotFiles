{
  description = "Sk7Str1p3's NixOS configuration";

  inputs = {
    # Nixpkgs branches
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
    nixpkgs.follows = "stable";
    # Unofficial repositories
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "stable";
    };
    # System Modules
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "stable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "stable";
    };
    sops = {
      url = "github:Mic92/sops-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "stable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "stable";
    };
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/latest";
      inputs.nixpkgs.follows = "stable";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "stable";
    };
    # Home Modules
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "stable";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "stable";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "stable";
    };
    #Additional Software

    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "stable";
    };
    nixos-conf-editor = {
      url = "github:snowfallorg/nixos-conf-editor";
      inputs.nixpkgs.follows = "stable";
    };
    prismLauncher = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = {
    flake-parts,
    self,
    ...
  } @ inputs: let
    hosts = import ./hosts.nix;
    helper = import ./helper {inherit self inputs;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = helper.forAllSystems;
      imports = [./flake-parts];
      flake = {
        nixosConfigurations = helper.mkNixos hosts.nixos;
      };
    };
}

{
  description = "Home manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      nixvim,
      ...
    }:

    let
      username = "szymon";
      # for git
      email = "szymon_jozef@proton.me";
      full_name = "Szymon P";
    in
    {
      homeConfigurations = {
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            inherit username email full_name;
            isNixOS = false;
          };
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            nixvim.homeModules.nixvim
          ];

        };
        "nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            inherit username email full_name;
            isNixOS = true;
          };
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}

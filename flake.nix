{
  description = "Home manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }:

    let
      user = "szymon";
      # for git
      email = "szymon_jozef@proton.me";
      full_name = "Szymon P";
    in
    {
      homeConfigurations = {
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            isNixOS = false;
            username = user;
            email = email;
            full_name = full_name;
          };
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
          ];

        };
        "nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            isNixOS = true;
            username = user;
            email = email;
            full_name = full_name;
          };
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}

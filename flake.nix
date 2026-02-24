{
  description = "Home manager config";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };

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
      wallpapers,
      ...
    }@inputs:

    let
      userConfig = {
        username = "szymon";
        # for git
        email = "szymon_jozef@proton.me";
        fullName = "Szymon P";
        # your public ssh key
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxyiqawA95AlLjXGd99sQCVR2rDq2/D7PG/vz7sZv5G";

        mainMonitor = "DP-1"; # only for some applications: you still need to set hyprland monitors yourself!
        statusBar = "ashell"; # available: ashell|waybar

        pathConfig = {
          wallpaper = "Obrazy/tapety/catppuccin";
        };

      };
    in
    {
      homeConfigurations = {
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            inherit
<<<<<<< HEAD
              username
              email
              full_name
              inputs
=======
              inputs
              userConfig
>>>>>>> c77553344515b404d765c04e1e472dac1cf4bb94
              ;
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
            inherit
<<<<<<< HEAD
              username
              email
              full_name
              inputs
=======
              inputs
              userConfig
>>>>>>> c77553344515b404d765c04e1e472dac1cf4bb94
              ;
            isNixOS = true;
          };
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            nixvim.homeModules.nixvim
          ];
        };
      };
    };
}

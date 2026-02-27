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
        signingKey = "~/.ssh/github.pub";

        mainMonitor = "eDP-1"; # only for some applications: you still need to set hyprland monitors yourself!
        statusBar = "ashell"; # available: ashell|waybar

        pathConfig = {
          wallpaper = "Obrazy/tapety/catppuccin";
          screenshot = "Obrazy/zrzuty/";
          obsidian = "Dokumenty/obsidian";
        };
      };

      system = "x86_64-linux";
      general_import = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      general_special_args = {
        inherit
          inputs
          userConfig
          ;
      };

      general_module_import = [
        ./home.nix
        catppuccin.homeModules.catppuccin
        nixvim.homeModules.nixvim
      ];

    in
    {
      homeConfigurations = {
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = general_import;

          extraSpecialArgs = general_special_args // {
            isNixOS = false;
          };

          modules = general_module_import;
        };

        "nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = general_import;

          extraSpecialArgs = general_special_args // {
            isNixOS = true;
          };

          modules = general_module_import;
        };
      };
    };
}

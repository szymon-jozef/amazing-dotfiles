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
      baseUserConfig = {
        username = "szymon";
        # for git
        email = "szymon_jozef@proton.me";
        fullName = "Szymon P";
        # your public ssh key
        signingKey = "~/.ssh/github.pub";

        mainMonitor = "DP-1"; # only for some applications: you still need to set hyprland monitors yourself!
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

      general_module_import = [
        ./home.nix
        catppuccin.homeModules.catppuccin
        nixvim.homeModules.nixvim
      ];

      mkHomeConfig =
        {
          isNixOS,
          overrides ? { },
          hostName,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = general_import;

          extraSpecialArgs = {
            inherit inputs isNixOS hostName;
            userConfig = baseUserConfig // overrides;
          };

          modules = general_module_import;
        };

    in
    {
      homeConfigurations = {
        "arch" = mkHomeConfig {
          isNixOS = false;
          hostName = "arch";
        };

        "nixos" = mkHomeConfig {
          isNixOS = true;
          hostName = "nixos";
        };

        "pitagoras" = mkHomeConfig {
          isNixOS = true;
          overrides = {
            mainMonitor = "eDP-1";
          };
          hostName = "pitagoras";
        };

        "pilecki" = mkHomeConfig {
          isNixOS = true;
          overrides = {
            mainMonitor = "LVDS-1";
          };
          hostName = "pilecki";
        };

        "paderewski" = mkHomeConfig {
          isNixOS = false;
          overrides = {
            mainMonitor = "DP-1";
          };
          hostName = "paderewski";
        };
      };
    };
}

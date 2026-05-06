{
  description = "Amazing dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #    hyprland.url = "github:hyprwm/Hyprland";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # theming stuff
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";
    wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };

    # uni stuff
    zut-calendar = {
      url = "github:szymon-jozef/zut-calendar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zutui = {
      url = "github:shv187/zutui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      catppuccin,
      nixvim,
      wallpapers,
      zut-calendar,
      zutui,
      ...
    }@inputs:

    let
      defaultUserConfig = {
        username = "szymon";
        email = "szymon_jozef@proton.me";
        fullName = "Szymon P";
        signingKey = "~/.ssh/github.pub";

        mainMonitor = "DP-1";
        statusBar = "ashell"; # available: ashell | waybar

        pathConfig = {
          wallpaper = "Obrazy/tapety/catppuccin";
          screenshot = "Obrazy/zrzuty/";
          obsidian = "Dokumenty/obsidian";
          projects = "Kodowanie";
          documents = "Dokumenty";
          pictures = "Obrazy";
          downloads = "Pobrane";
          video = "Video";
        };

        isNixOS = true;
        hostName = "default";
        animations = true;
        gaming = true;
      };

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-38.8.4"
          ];
        };
      };

      mkHome =
        customConfig:
        let
          userConfig = defaultUserConfig // customConfig;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs userConfig pkgs-stable;
          };

          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            nixvim.homeModules.nixvim
            inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
            (
              { pkgs, ... }:
              {
                home.packages = [
                  zut-calendar.packages.${pkgs.stdenv.hostPlatform.system}.default
                  zutui.packages.${pkgs.stdenv.hostPlatform.system}.default
                ];
              }
            )
          ]
          ++ (customConfig.extraModules or [ ]);
        };

    in
    {
      homeConfigurations = {
        # You can overwrite default configuration here

        "arch" = mkHome {
          isNixOS = false;
          hostName = "arch";
        };

        "nixos" = mkHome {
          isNixOS = true;
          hostName = "nixos";
        };

        "${defaultUserConfig.username}@pitagoras" = mkHome {
          hostName = "pitagoras";
          mainMonitor = "eDP-1";
          animations = false;
        };

        "${defaultUserConfig.username}@pilecki" = mkHome {
          hostName = "pilecki";
          mainMonitor = "LVDS-1";
        };

        "${defaultUserConfig.username}@paderewski" = mkHome {
          hostName = "paderewski";
        };
      };
    };
}

{
  pkgs,
  inputs,
  userConfig,
  pathConfig,
  ...
}:

{
  home.username = userConfig.username;
  home.homeDirectory = "/home/${userConfig.username}";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # === THEME ===
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  imports = [
    # general
    ./modules/packages.nix
    ./modules/xdg.nix
    ./modules/desktop.nix
    ./modules/gtk.nix
    # cli tools
    ./modules/cli/fish.nix
    ./modules/cli/nixvim.nix
    ./modules/cli/yazi.nix
    ./modules/cli/btop.nix
    ./modules/cli/atuin.nix
    ./modules/cli/zoxide.nix
    ./modules/cli/ssh.nix
    ./modules/cli/bat.nix
    ./modules/cli/git.nix
    ./modules/cli/fastfetch.nix
    # gui tools
    ./modules/gui/kitty.nix
    ./modules/gui/satty.nix
    ./modules/gui/mako.nix
    ./modules/gui/mangohud.nix
    # status bars
    ./modules/bars/ashell.nix
    ./modules/bars/waybar.nix
    # hypr
    ./modules/hypr/hyprland.nix
    ./modules/hypr/hyprlauncher.nix
    ./modules/hypr/hypridle.nix
    ./modules/hypr/hyprlock.nix
    ./modules/hypr/hyprsunset.nix
    ./modules/hypr/hyprtoolkit.nix
  ];

  # === SCRIPTS IMPORT ===
  home.file = {
    ".local/bin".source = ./scripts;
    ${pathConfig.wallpaper}.source = inputs.wallpapers;
  };

  # === VARS ===

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11"; # DONT CHANGE ME UwU
}

{
  pkgs,
  username,
  ...
}:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

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
  ];

  # === DOTFILES IMPORT ===
  home.file = {
    ".config/gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;
    ".config/gtk-4.0".source = ./dotfiles/gtk-4.0;
    ".config/mimeapps.list".source = ./dotfiles/mimeapps.list;
    ".local/bin".source = ./scripts;
  };

  # === VARS ===

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11"; # DONT CHANGE ME UwU
}

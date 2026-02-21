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
    ./modules/packages.nix
    ./modules/fish.nix
    ./modules/yazi.nix
    ./modules/btop.nix
    ./modules/atuin.nix
    ./modules/zoxide.nix
    ./modules/mako.nix
    ./modules/ssh.nix
    ./modules/bat.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/satty.nix
    ./modules/ashell.nix
    ./modules/waybar.nix
  ];

  # === DOTFILES IMPORT ===
  home.file = {
    ".config/fastfetch".source = ./dotfiles/fastfetch;
    ".config/MangoHud".source = ./dotfiles/mangohud;
    ".config/nvim".source = ./dotfiles/nvim;
    ".config/gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;
    ".config/gtk-4.0".source = ./dotfiles/gtk-4.0;
    ".config/hypr".source = ./dotfiles/hypr;
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

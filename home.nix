{
  pkgs,
  isNixOS,
  username,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.file."test-os.txt".text = if isNixOS then "this is nixos" else "this is arch";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

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
  ];

  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/fastfetch".source = ./dotfiles/fastfetch;
    ".config/MangoHud".source = ./dotfiles/mangohud;
    ".config/nvim".source = ./dotfiles/nvim;
    ".config/gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;
    ".config/gtk-4.0".source = ./dotfiles/gtk-4.0;
    ".config/waybar".source = ./dotfiles/waybar;
    ".config/hypr".source = ./dotfiles/hypr;
    ".config/mimeapps.list".source = ./dotfiles/mimeapps.list;
    ".local/bin".source = ./scripts;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "szymon";
  home.homeDirectory = "/home/szymon";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  imports = [
    ./modules/packages.nix
    ./modules/fish.nix
    ./modules/yazi.nix
    ./modules/btop.nix
    ./modules/atuin.nix
    ./modules/zoxide.nix
  ];

  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ashell/config.toml".source = ./dotfiles/ashell/config.toml;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "/home/szymon/.lmstudio/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

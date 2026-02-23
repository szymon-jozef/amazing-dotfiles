{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waypaper
    swww
    gnupg
    libnotify
    cliphist
    gh
    trash-cli
    pandoc
    fzf
    eza
    fastfetch
    fd
    duf
    gdu
    jq
    tealdeer
    grim
    slurp
    bc
    nh
  ];
}

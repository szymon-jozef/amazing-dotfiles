{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
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

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
    trash-cli
    pandoc
    fzf
    eza
    fastfetch
    fd
    duf
    gdu
    tealdeer
    grim
    slurp
    bc
    nh
  ];
}

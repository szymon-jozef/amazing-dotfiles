{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
    trash-cli
    pandoc
    fzf
    eza
    fastfetch
    neovim
    fd
    duf
    gdu
    tealdeer
    grim
    slurp
    wl-clipboard
    bc
  ];
}

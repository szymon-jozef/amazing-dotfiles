{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
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
    mako
    bc
  ];
}

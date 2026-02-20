{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
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

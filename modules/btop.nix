{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "catppuccin_mocha";
    };
  };
}

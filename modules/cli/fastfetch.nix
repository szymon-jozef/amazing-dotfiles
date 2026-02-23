{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "packages"
        "separator"
        "wm"
        "shell"
        "terminal"
        "theme"
        "font"
        "locale"
        "separator"
        "display"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "battery"
        "separator"
        "wifi"
        "localip"
        "break"
        "colors"
      ];
    };
  };

  xdg.configFile."fastfetch/startup.jsonc".text = builtins.toJSON {
    logo = {
      source = "arch_small";
      padding = {
        bottom = 1;
      };
    };
    display = {
      separator = " ➜ ";
    };
    modules = [
      "title"
      "kernel"
      "packages"
      "shell"
      "battery"
      {
        type = "separator";
        string = " • ";
      }
      "break"
      "break"
      "break"
    ];
  };
}

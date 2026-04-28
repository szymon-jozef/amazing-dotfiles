{
  userConfig,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = lib.mkIf (!userConfig.isNixOS) null;
  };

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    tutanota-desktop
    brave
  ];
}

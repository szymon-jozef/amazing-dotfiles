{ userConfig, lib, ... }:

{
  programs.chromium = {
    enable = true;
    package = lib.mkIf (!userConfig.isNixOS) null;
  };
}

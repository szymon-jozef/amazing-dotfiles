{ isNixOS, lib, ... }:

{
  programs.chromium = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;
  };
}

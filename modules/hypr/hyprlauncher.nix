{ isNixOS, lib, ... }:

{
  services.hyprlauncher = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;

    settings = {
      cache.enabled = true;

      finders = {
        desktop_icons = true;
        desktop_launch_prefix = "uwsm app --";
      };

      general = {
        grab_focus = true;
      };

    };
  };
}

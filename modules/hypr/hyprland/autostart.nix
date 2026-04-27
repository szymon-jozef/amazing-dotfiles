{
  userConfig,
  pkgs,
  ...
}:
let
  uwsm_run = "${pkgs.uwsm}/bin/uwsm";
in
{
  wayland.windowManager.hyprland = {
    "exec-once" = [
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "${uwsm_run} -- ${userConfig.statusBar}"
      "awww-daemon"
      "openrgb -c $openrgb_color"
    ];
  };
}

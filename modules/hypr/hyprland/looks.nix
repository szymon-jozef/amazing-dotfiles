{
  userConfig,
  pkgs,
  ...
}:
let
in
{
  wayland.windowManager.hyprland = {
    animations = {
      enabled = userConfig.animations;
      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];
      animation = [
        "global, 1, 7, default"
        "border, 1, 3.39, easeOutQuint"
        "windows, 1, 2.79, easeOutQuint"
        "windowsIn, 1, 2.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1, linear, popin 87%"
        "fadeIn, 1, 1.4, almostLinear"
        "fadeOut, 1, 1.2, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 2, easeOutQuint"
        "layersIn, 1, 2, easeOutQuint, fade"
        "layersOut, 1, 1, linear, fade"
        "fadeLayersIn, 1, 1.4, almostLinear"
        "fadeLayersOut, 1, 1.1, almostLinear"
        "workspaces, 1, 1.4, quick, slidevert"
        "workspacesIn, 1, 0.5, quick, slidevert"
        "workspacesOut, 1, 0.5, quick, slidevert"
      ];
    };

    decoration = {
      rounding = 1;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      shadow = {
        enabled = true;
        range = 1;
        render_power = 1;
        color = "$overlay0";
      };
      blur = {
        enabled = true;
        size = 1;
        passes = 1;
        vibrancy = 0.1696;
      };
    };
  };
}

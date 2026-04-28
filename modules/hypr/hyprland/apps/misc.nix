{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {

      windowrule = [
        # general rules
        "match:class ^(winboat)$, workspace 5"
        "match:class ^(qemu)$, workspace 5"
        "match:class ^(obsidian)$, workspace 6"
        "match:class ^(gimp)$, workspace 8"
        "match:class .*potify, workspace 9 silent"
        "match:class ^(com.obsproject.Studio)$, workspace 10"
      ];

      bind = [
        "$mainMod, M, exec, [float] waypaper"
        "$mainMod, RETURN, exec, [workspace 4] $terminal"
        "$mainMod  CONTROL_L, RETURN, exec, $terminal"
        "$mainMod, space , exec, $menu"
        "$mainMod ALT_L, c, exec, openrgb -c $openrgb_color"
        "$mainMod Control_L, n, exec, [workspace 6] uwsm app -- $notes"
        "$mainMod Control_L, n, focuswindow, class:^(obsidian)$"
        "$mainMod Control_L, m, exec, [workspace 9] uwsm app -- $music_player"
        "$mainMod CONTROL_L L_SHIFT, B, exec, killall ashell && uwsm app -- ashell"
      ];
    };

    extraConfig =
      #hyprlang
      ''
        windowrule {
            name = pavucontrol-float
            match:class = ^(org.pulseaudio.pavucontrol)$
            float =  1
            size = 80% 60%
            stay_focused = 1
            center = 1
            pin = 1
        }

        windowrule {
            name = share-picker-float
            match:class = ^(hyprland-share-picker)$
            float = 1
            center = 1
            pin = 1
        }

        windowrule {
            name = xdg-desktop-portal-gtk
            match:class = ^(xdg-desktop-portal-gtk)$
            float = 1
            center = 1
            size = 55% 50%
        }

      '';
  };
}

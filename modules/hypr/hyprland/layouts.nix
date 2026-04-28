{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {

    dwindle = {
      preserve_split = true;
    };

    master = {
      new_status = "slave";
      allow_small_split = true;
      orientation = "left";
    };

    bind = [
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      "$mainMod L_SHIFT, right, exec, hyprctl dispatch movecurrentworkspacetomonitor +1"
      "$mainMod L_SHIFT, left, exec, hyprctl dispatch movecurrentworkspacetomonitor -1"
      # workspace management
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      # window management
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      # special workspace
      "$mainMod, TAB, togglespecialworkspace, magic"
      "$mainMod SHIFT, TAB, movetoworkspace, special:magic"
      # layout
      "$mainMod, S, layoutmsg, swapwithmaster"
      "$mainMod, n, layoutmsg, swapnext"
      "$mainMod, p, layoutmsg, swapprev"
    ];

    binde = [
      "$mainMod alt, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"
      "$mainMod alt, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"
      "$mainMod alt, 0, exec, hyprctl -q keyword cursor:zoom_factor 1"
      "$mainMod L_SHIFT, l, resizeactive, 10 0"
      "$mainMod L_SHIFT, h, resizeactive, -10 0"
      "$mainMod L_SHIFT, k, resizeactive, 0 -10"
      "$mainMod L_SHIFT, j, resizeactive, 0 10"
    ];

    bindd = [
      "$mainMod, F, Make app fullscreen, fullscreen"
      "$mainMod, T, Toggle floating, togglefloating"
      "$mainMod, Q, Kill active window, killactive"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}

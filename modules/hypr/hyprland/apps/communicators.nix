{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {

      windowrule = [
        # general rules
        "match:class ^(signal)$, workspace 1"
        "match:class ^(vesktop)$, workspace 1 silent"
      ];

      bind = [
        "$mainMod Control_L, s, exec,[workspace 1] $signal_client"
        "$mainMod Control_L, s, focuswindow, class:^(signal)$"
        "$mainMod Control_L, s, focuswindow, title:^(signal)$"
        "$mainMod Control_L, v, sendshortcut, ctrl, k, class:^(vesktop)$"
        "$mainMod Control_L, v, exec, uwsm app -- vesktop"
        "$mainMod Control_L, v, focuswindow, class:^(vesktop)$"
      ];

    };
    extraConfig =
      #hyprlang
      ''
        windowrule {
            name = vesktop-dont-focus-pls
            match:class = ^(vesktop)$
            no_initial_focus = 1
            focus_on_activate = 0
            render_unfocused = 1
        }

      '';
  };
}

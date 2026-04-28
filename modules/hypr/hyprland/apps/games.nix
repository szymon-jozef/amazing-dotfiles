{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "match:class ^(steam)$, workspace 3 silent"
        "match:class ^(heroic)$, workspace 3"
        "match:class ^(net.lutris.Lutris)$, workspace 3"
        "match:class ^(rpcs3)$, workspace 3"
      ];

      bind = [
        "$mainMod Control_L, g, exec, uwsm app -- steam"
        "$mainMod Control_L, g, focuswindow, class:^(steam)$"
      ];
    };
    extraConfig =
      #hyprlang
      ''
        windowrule {
            name = steam-friends-list
            match:title = ^(Lista znajomych)$
            float = 1
            center = 1
            size = 40% 60%
        }

        windowrule {
            name = prism-launcher
            match:class = ^(org.prismlauncher.PrismLauncher)$
            workspace = 3
        }

        windowrule {
            name = gamescope
            match:class = ^(gamescope)$
            workspace = 3
        }
      '';
  };
}

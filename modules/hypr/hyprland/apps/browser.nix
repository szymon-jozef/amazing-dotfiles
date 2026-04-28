{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "match:class ^(chrome-facebook.com__-Default)$, workspace 1"
        "match:class ^(zen)$, workspace 2"
        "match:class ^(zen-beta)$, workspace 2"
        "match:class ^(com.github.IsmaelMartinez.teams_for_linux)$, workspace 2"
        "match:class ^(FreeTube)$, workspace 2"
        "match:class ^(brave-x.com__-Default)$, workspace 2"
        "match:class ^(chrome-www.inoreader.com__all_articles-Default)$, workspace 2"
        "match:class ^(chrome-mail.proton.me__u_0_inbox.com-Default)$, workspace 2"
        "match:class ^(chrome-app.tuta.com__-Default)$, workspace 2"
      ];

      bind = [
        "$mainMod Control_L, b, exec, uwsm app -- $browser"
        "$mainMod Control_L, b, focuswindow, class:^(zen)$"
        "$mainMod Control_L, f, exec, uwsm app -- freetube"
        "$mainMod Control_L, f, focuswindow, class:^(freetube)$"
        "$mainMod Control_L, x, exec, uwsm app -- ~/.nix-profile/share/applications/x.desktop"
        "$mainMod Control_L, x, focuswindow, class:^(chrome-x.com__-Default)$"
      ];
    };

    extraConfig =
      #hyprlang
      ''
        windowrule {
            name = picture-in-picture
            match:title = ^(Obraz w obrazie)$
            pseudo = 1
            no_initial_focus = 1
        }

        windowrule {
            name = login-google-zen
            match:title = ^(Logowanie – Konta Google — Zen Browser)$
            float = 1
            center = 1
        }

      '';
  };
}

{ isNixOS, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "uwsm app -- kitty";
      "$menu" = "hyprlauncher";
      "$music_player" = "flatpak run com.spotify.Client";
      "$notes" = "obsidian";
      "$browser" = "zen-browser";
      "$openrgb_color" = "09ce30";

      env = [
        "XCURSOR_SIZE, 32"
        "HYPRCURSOR_SIZE, 32"
        "HYPRCURSOR_THEME, theme_phinger-cursors-light"
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 4;
        "col.active_border" = "$blue $sky";
        "col.inactive_border" = "$overlay1";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      animations = {
        enabled = true;
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

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        allow_small_split = true;
        orientation = "left";
      };

      ecosystem = {
        enforce_permissions = true;
      };

      permission = [
        ".*(grim), screencopy, allow"
        ".*(hyprlock), screencopy, allow"
        ".*(xdg-desktop-portal-hyprland), screencopy, allow"
      ];

      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape_shifted_capslock";
        kb_rules = "";
        follow_mouse = 1;
        left_handed = true;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      cursor = {
        no_hardware_cursors = true;
        inactive_timeout = 5;
        warp_on_change_workspace = 1;
        zoom_factor = 1.0;
        hide_on_key_press = 1;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        middle_click_paste = false;
      };

      xwayland = {
        force_zero_scaling = 1;
      };

      quirks = {
        prefer_hdr = 1;
      };

      "exec-once" = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "uwsm app -- kdeconnect-indicator"
        "uwsm app -- ashell"
        "swww-daemon"
        "openrgb -c $openrgb_color"
      ];

      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:HDMI-A-2"
        "9, monitor:DP-2"
        "10, monitor:DP-2"
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrule = [
        # smart gaps
        "border_size 0, match:float 0, match:workspace w[tv1]"
        "rounding 0, match:float 0, match:workspace w[tv1]"
        "border_size 0, match:float 0, match:workspace f[1]"
        "rounding 0, match:float 0, match:workspace f[1]"
        # general rules
        "match:class ^(signal)$, workspace 1"
        "match:class ^(vesktop)$, workspace 1 silent"
        "match:class ^(chrome-facebook.com__-Default)$, workspace 1"
        "match:class ^(zen)$, workspace 2"
        "match:class ^(com.github.IsmaelMartinez.teams_for_linux)$, workspace 2"
        "match:class ^(FreeTube)$, workspace 2"
        "match:class ^(chrome-x.com__-Default)$, workspace 2"
        "match:class ^(chrome-www.inoreader.com__all_articles-Default)$, workspace 2"
        "match:class ^(chrome-mail.proton.me__u_0_inbox.com-Default)$, workspace 2"
        "match:class ^(chrome-app.tuta.com__-Default)$, workspace 2"
        "match:class ^(steam)$, workspace 3 silent"
        "match:class ^(heroic)$, workspace 3"
        "match:class ^(net.lutris.Lutris)$, workspace 3"
        "match:class ^(rpcs3)$, workspace 3"
        "match:class ^(winboat)$, workspace 5"
        "match:class ^(obsidian)$, workspace 6"
        "match:class ^(gimp)$, workspace 8"
        "match:class .*potify, workspace 9 silent"
        "match:class ^(com.obsproject.Studio)$, workspace 10"
      ];

      bind =
        # hyprlang
        [
          # background
          "$mainMod, V, exec, cliphist list | hyprlauncher -m | cliphist decode | wl-copy"
          "$mainMod ALT_L, V, exec, cliphist wipe && notify-send \"Clipboard\" \"Clipboard cleared!\""
          # power management
          "$mainMod L_SHIFT ctrl, l, exec, hyprlock"
          "$mainMod L_SHIFT ctrl, r, exec, openrgb -c black && systemctl reboot"
          "$mainMod L_SHIFT ctrl, p, exec, openrgb -c black && systemctl poweroff"
          "$mainMod L_SHIFT ctrl, s, exec, openrgb -c black && pidof hyprlock || sleep 1 && systemctl sleep"
          "$mainMod L_SHIFT ctrl, m, exec, uwsm stop"
          # zoom
          "$mainMod alt, 0, exec, hyprctl -q keyword cursor:zoom_factor 1"
          # focus management
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
          # apps
          "$mainMod, M, exec, [float] waypaper"
          "$mainMod, RETURN, exec, [workspace 4] $terminal"
          "$mainMod  CONTROL_L, RETURN, exec, $terminal"
          "$mainMod, space , exec, $menu"
          "$mainMod ALT_L, c, exec, openrgb -c $openrgb_color"
          "$mainMod Control_L, s, exec,[workspace 1] signal-desktop --password-store=\"kwallet6\""
          "$mainMod Control_L, s, focuswindow, class:^(signal)$"
          "$mainMod Control_L, s, focuswindow, title:^(signal)$"
          "$mainMod Control_L, v, sendshortcut, ctrl, k, class:^(vesktop)$"
          "$mainMod Control_L, v, exec, uwsm app -- vesktop"
          "$mainMod Control_L, v, focuswindow, class:^(vesktop)$"
          "$mainMod Control_L, g, exec, uwsm app -- steam"
          "$mainMod Control_L, g, focuswindow, class:^(steam)$"
          "$mainMod Control_L, b, exec, uwsm app -- $browser"
          "$mainMod Control_L, b, focuswindow, class:^(zen)$"
          "$mainMod Control_L, n, exec, [workspace 6] uwsm app -- $notes"
          "$mainMod Control_L, n, focuswindow, class:^(obsidian)$"
          "$mainMod Control_L, m, exec, [workspace 9] uwsm app -- $music_player"
          "$mainMod Control_L, f, exec, uwsm app -- freetube"
          "$mainMod Control_L, f, focuswindow, class:^(freetube)$"
          "$mainMod Control_L, x, exec, uwsm app -- ~/.local/share/applications/x.desktop"
          "$mainMod Control_L, x, focuswindow, class:^(chrome-x.com__-Default)$"
          "$mainMod CONTROL_L L_SHIFT, B, exec, killall ashell && uwsm app -- ashell"
        ];

      binde = [
        "$mainMod alt, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"
        "$mainMod alt, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"
        "$mainMod L_SHIFT, l, resizeactive, 10 0"
        "$mainMod L_SHIFT, h, resizeactive, -10 0"
        "$mainMod L_SHIFT, k, resizeactive, 0 -10"
        "$mainMod L_SHIFT, j, resizeactive, 0 10"
      ];

      bindel = [
        ",XF86MonBrightnessDown, exec, hyprctl hyprsunset gamma -10"
        ",XF86MonBrightnessUp, exec, hyprctl hyprsunset gamma +10"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ~/.local/bin/wp-vol.sh && paplay /usr/share/sounds/freedesktop/stereo/bell.oga"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.local/bin/wp-vol.sh && paplay /usr/share/sounds/freedesktop/stereo/bell.oga"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle && ~/.local/bin/check-if-muted.sh"
        ", XF86AudioNext, exec, playerctl next"
        ", Pause, exec, playerctl play-pause"
        "$mainMod, Pause, exec, playerctl play-pause --player spotify"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindt = [
        ", PRINT, exec, ~/.local/bin/screenshot.sh region"
        "$mainMod, PRINT, exec, ~/.local/bin/screenshot.sh fullscreen"
        "alt_l, PRINT, exec, ~/.local/bin/screenshot.sh window"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindd = [
        "$mainMod, F, Make app fullscreen, fullscreen"
        "$mainMod, T, Toggle floating, togglefloating"
        "$mainMod, P, Toggle pseudo, pseudo"
        "$mainMod, S, Toggle split, togglesplit"
        "$mainMod, Q, Kill active window, killactive"
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
             name = steam-friends-list
             match:title = ^(Lista znajomych)$
             float = 1
             center = 1
             size = 40% 60%
         }

         windowrule {
             name = vesktop-dont-focus-pls
             match:class = ^(vesktop)$
             no_initial_focus = 1
             focus_on_activate = 0
             render_unfocused = 1
         }

         windowrule {
             name = xdg-desktop-portal-gtk
             match:class = ^(xdg-desktop-portal-gtk)$
             float = 1
             center = 1
             size = 55% 50%
         }

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

         monitorv2 {
             output = DP-1
             mode = 2560x1440@180.06
             position = 0x0
             scale = 1
             vrr = 1
             supports_wide_color = 1
             bitdepth = 10
             sdr_min_luminance = 0.005
             sdr_max_luminance = 220
             cm = hdr
             supports_hdr = 1
         }

         monitorv2 {
             output = DP-2
             mode = 1920x1080@144
             position = auto-left
             vrr = 1
             scale = 1.0
         }

         monitorv2 {
             output = HDMI-A-2
             mode = highres
             position = auto-up
             scale = 1
         }

        # for laptop
        monitorv2 {
             output = eDP-1
             mode = highres
             position = 0x0
             scale = 1
         }

         monitorv2 {
             output = 
             position = auto-right
             scale = 1
         }
      '';
  };
}

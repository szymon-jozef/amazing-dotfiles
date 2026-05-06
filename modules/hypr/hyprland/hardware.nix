{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape_shifted_capslock";
        kb_rules = "";
        follow_mouse = 1;
        left_handed = false;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      # mouse has super high dpi so lover the sensitivity!
      device = {
        name = "corsair-corsair-m75-gaming-mouse";
        sensitivity = -0.5;
      };

      cursor = {
        no_hardware_cursors = true;
        inactive_timeout = 5;
        warp_on_change_workspace = 1;
        zoom_factor = 1.0;
        hide_on_key_press = 1;
      };

      bindel = [
        ",XF86MonBrightnessDown, exec, hyprctl hyprsunset gamma -10"
        ",XF86MonBrightnessUp, exec, hyprctl hyprsunset gamma +10"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ~/.local/bin/wp-vol.sh && paplay /usr/share/sounds/freedesktop/stereo/bell.oga"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/.local/bin/wp-vol.sh && paplay /usr/share/sounds/freedesktop/stereo/bell.oga"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ];
    };

    extraConfig =
      #hyprlang
      ''
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

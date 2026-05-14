{
  userConfig,
  pkgs,
  ...
}:
let
  uwsm_run = "${pkgs.uwsm}/bin/uwsm app";
  signal_client = "${pkgs.kitty}/bin/kitty --title 'gurk' ${pkgs.gurk-rs}/bin/gurk";
in
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "${uwsm_run} -- ${pkgs.kitty}/bin/kitty";
      "$menu" = "${pkgs.hyprlauncher}/bin/hyprlauncher";
      "$music_player" =
        if userConfig.isNixOS then "${pkgs.spotify}/bin/spotify" else "flatpak run com.spotify.Client";
      "$notes" = "${pkgs.obsidian}/bin/obsidian";
      "$browser" = if userConfig.isNixOS then "zen-beta" else "zen-browser"; # beta on nixos
      "$openrgb_color" = "09ce30";
      "$signal_client" = signal_client;

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
        layout = "scrolling";
      };
    };
  };
}

{
  userConfig,
  pkgs,
  ...
}:
let
  uwsm_run = "${pkgs.uwsm}/bin/uwsm";
  exe = pkg: bin: if userConfig.isNixOS then "${pkg}/bin/${bin}" else "/usr/bin/${bin}";
  jq = exe pkgs.jq "jq";
  grim = exe pkgs.grim "grim";
  satty = exe pkgs.satty "satty";
  wl_copy = exe pkgs.wl-clipboard "wl-copy";
  notify_send = exe pkgs.libnotify "notify-send";
  playerctl = exe pkgs.playerctl "playerctl";
in
{
  wayland.windowManager.hyprland = {

    enable = true;
    package =
      if userConfig.isNixOS then
        #  inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        pkgs.hyprland
      else
        null;
    #portalPackage = lib.mkIf (userConfig.isNixOS
    #) inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
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

    ecosystem = {
      enforce_permissions = true;
    };

    permission = [
      "^${pkgs.grim}$, screencopy, allow"
      "^${pkgs.hyprlock}$, screencopy, allow"
      "^${pkgs.xdg-desktop-portal-hyprland}$, screencopy, allow"
    ];

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

    windowrule = [
      # smart gaps
      "border_size 0, match:float 0, match:workspace w[tv1]"
      "rounding 0, match:float 0, match:workspace w[tv1]"
      "border_size 0, match:float 0, match:workspace f[1]"
      "rounding 0, match:float 0, match:workspace f[1]"
    ];

    bindt = [
      ", PRINT, exec, ${pkgs.writeShellScript "screenshot-region" ''
        MONITOR=$(hyprctl monitors -j | ${jq} -r '.[] | select(.focused == true) | .name')
        ${grim} -o "$MONITOR" - | ${satty} -f -
      ''}"

      "$mainMod, PRINT, exec, ${pkgs.writeShellScript "screenshot-fullscreen" ''
        target_path="$HOME/${userConfig.pathConfig.screenshot}/$(date +'%d-%m-%Y_%H-%M-%S').png"
        mkdir -p "$(dirname "$target_path")"

        MONITOR=$(hyprctl monitors -j | ${jq} -r '.[] | select(.focused == true) | .name')

        ${grim} -o "$MONITOR" "$target_path"
        ${wl_copy} < "$target_path"
        ${notify_send} -i "$target_path" -u low -a "Screenshot" "Screenshot fullscreen" "Saved and copied"
      ''}"

      "alt_l, PRINT, exec, ${pkgs.writeShellScript "screenshot-window" ''
        target_path="$HOME/${userConfig.pathConfig.screenshot}/$(date +'%d-%m-%Y_%H-%M-%S').png"
        mkdir -p "$(dirname "$target_path")"

        GEOMETRY=$(hyprctl activewindow -j | ${jq} -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

        ${grim} -g "$GEOMETRY" "$target_path"
        ${wl_copy} < "$target_path"
        ${notify_send} -i "$target_path" -u low -a "Screenshot" "Screenshot window" "Saved and copied"
      ''}"

      ", PAUSE, exec, ${playerctl} play-pause"
      "$mainMod, PAUSE, exec, ${playerctl} play-pause --player spotify"
    ];
  };
}

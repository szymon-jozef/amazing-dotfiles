{
  pkgs,
  isNixOS,
  ...
}:

{
  programs.waybar = {
    enable = true;
    package =
      if isNixOS then pkgs.waybar else (pkgs.writeShellScriptBin "waybar" "exec /usr/bin/waybar \"$@\"");
    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        spacing = 4;
        margin-top = 10;
        margin-bottom = 10;
        margin-left = 8;
        margin-right = 8;
        mode = "dock";
        reload_style_on_change = true;
        width = 70;
        output = [
          "DP-1"
          "eDP-1"
          "LVDS-1"
        ];

        modules-left = [
          "clock"
          "custom/notifications"
          "privacy"
          "custom/spotify"
          "pulseaudio"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{} - {icon}";
          on-click = "activate";
          on-click-right = "close";
          all-outputs = true;
          active-only = false;
          sort-by-number = true;
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            default = "";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "<big>{:%R}</big>";
          format-alt = "<small>{:%d.%m.%Y}</small>";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "tz_up";
              on-scroll-down = "tz_down";
            };
          };
        };

        network = {
          format-wifi = " ({signalStrength}%)   ";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} with {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          on-click = "kitty nmtui";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "  ";
          format-source = " {volume}% ";
          format-source-muted = "  ";
          format-icons = {
            headphone = "";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol -t 3";
          on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };

        "custom/spotify" = {
          format = "{}";
          return-type = "json";
          on-click = "playerctl play-pause --player spotify";
          on-click-right = "killall spotify";
          on-scroll-up = "playerctl next --player spotify";
          on-scroll-down = "playerctl previous --player spotify";
          restart-interval = 0;
          hide-empty-text = true;
          justify = "center";
          max-length = 40;
          exec =
            let
              playerctl = "${pkgs.playerctl}/bin/playerctl";
              jq = "${pkgs.jq}/bin/jq";
              pkill = "${pkgs.procps}/bin/pkill";

              mediaPlayerScript = pkgs.writeShellScript "mediaplayer" ''
                if [ -z "$1" ]; then
                  echo "Użycie: $0 <nazwa_odtwarzacza>"
                  exit 1
                fi

                player="$1"

                ${playerctl} -p "$player" metadata --format "{{status}} {{artist}} - {{title}}" --follow | while read -r line; do
                  # Nix wymaga ''${ dla zmiennych basha w stringach nixowych
                  current_status=$(${playerctl} --player="$player" status 2>/dev/null)
                  
                  case "$current_status" in
                    "Playing")
                      icon=""
                      ;;
                    "Paused")
                      icon=""
                      ;;
                    *)
                      icon=""
                      ;;
                  esac

                  tooltip=$(${playerctl} --player="$player" metadata --format "{{artist}} - {{title}}" 2>/dev/null)
                  
                  ${jq} -nc --arg text "$icon" --arg tooltip "$tooltip" \
                    '{"text": $text, "tooltip": $tooltip}'

                  if [[ -n "$icon" ]]; then
                    ${pkill} -SIGRTMIN+1 waybar
                  fi
                done
              '';
            in
            "${mediaPlayerScript} spotify";
        };

        "custom/notifications" = {
          format = "<big>{text}</big>";
          on-click-right = "~/.local/bin/check-do-not-disturb.sh change";
          exec = "~/.local/bin/check-do-not-disturb.sh show";
          exec-on-event = "~/.local/bin/check-do-not-disturb.sh show";
          tooltip = false;
          return-type = "text";
          signal = 2;
        };
      };
    };

    style = ''

      /* Global styles */
      * {
          transition: 0.2s all ease-in-out;
          font-size: 14px;
          font-family: inherit;
          padding: 3px;
          margin: 1px 2px;
          color: @text;
          border-radius: 12px;
      }

      *:hover {
          text-shadow: none;
      }

      /* Window */
      window#waybar {
          background-color: @base;
          border-radius: 15px;
      }

      /* Workspaces */
      #workspaces button {
          padding: 2px;
          margin: 1px;
          background: transparent;
          color: @lavender;
          box-shadow: inset 0 1.5px;
      }

      #workspaces button:hover {
          background-color: @surface1;
          box-shadow: inset 2px 5px;
      }

      #workspaces button.active {
          background-color: @surface0;
          box-shadow: inset 1px 4px 0 1px;
      }

      #workspaces button.urgent {
          background-color: @red;
          animation-name: blink;
          animation-duration: 1s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* Clock */
      #clock {
          font-style: oblique;
          opacity: 1;
      }

      /* Modules */
      .modules-left,
      .modules-right,
      .modules-center {
          background-color: @crust;
      }

      /* Tray */
      #tray>.needs-attention {
          background-color: @red;
      }

      /* Custom */
      #custom-spotify:hover {
          background-color: @green;
      }

      #network:hover {
          background-color: @sky;
      }

      #custom-notifications:hover {
          background-color: @sapphire;
      }

      /* Battery */
      #battery {
          background-color: @base;
      }

      #battery.warning:not(.charging) {
          background: @yellow;
          color: @foreground;
          animation-name: blink;
          animation-duration: 1s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery.charging,
      #battery.plugged {
          color: @foreground;
          background-color: @green;
      }

      #battery.critical:not(.charging) {
          background-color: @red;
          color: @foreground;
          animation-name: blink;
          animation-duration: 1s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #ff0000;
              color: #000000;
          }
      }
    '';

  };
}

{
  lib,
  isNixOS,
  userConfig,
  pkgs,
  ...
}:

{
  programs.ashell = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;
    settings = {
      outputs = {
        Targets = [ userConfig.mainMonitor ];
      };
      position = "Bottom";
      modules = {

        left = [
          "Clock"
          "Workspaces"
        ];
        center = [ "WindowTitle" ];
        right = [
          "Privacy"
          "MediaPlayer"
          "SystemInfo"
          [
            "CustomNotifications"
            "Tray"
            "Settings"
          ]
        ];
      };

      CustomModule = [
        {
          name = "CustomNotifications";
          icon = "";
          command = "${pkgs.writeShellScript "dnd-toggle" ''
            if makoctl mode | grep -q do-not-disturb; then
              makoctl mode -r do-not-disturb > /dev/null
            else
              makoctl mode -a do-not-disturb > /dev/null
            fi
            pkill -USR1 -f dnd-check 
          ''}";
          listen_cmd = "${pkgs.writeShellScript "dnd-check" ''
            print_state() {
              if makoctl mode | grep -q do-not-disturb; then
                echo '{"alt":"dnd"}'
              else
                echo '{"alt":"none"}'
              fi
            }

            trap print_state USR1

            print_state

            while true; do
              sleep infinity & wait $!
            done
          ''}";
          icons.dnd = "";
        }
      ];

      clock = {
        format = "%H:%M | %e.%m ";
      };

      settings = {
        remove_airplane_btn = true;
      };

      appearance = {
        scale_factor = 1.2;
        style = "Gradient";
        success_color = "#a6e3a1";
        text_color = "#cdd6f4";
        workspace_colors = [
          "#fab387"
          "#b4befe"
          "#cba6f7"
        ];

        primary_color = {
          base = "#fab387";
          text = "#1e1e2e";
        };

        danger_color = {
          base = "#f38ba8";
          weak = "#f9e2af";
        };

        background_color = {
          base = "#1e1e2e";
          weak = "#313244";
          strong = "#45475a";
        };

        secondary_color = {
          base = "#11111b";
          strong = "#1b1b25";
        };
      };

    };
  };
}

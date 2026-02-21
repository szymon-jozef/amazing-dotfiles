{ ... }:

{
  programs.ashell = {
    enable = true;
    package = null;
    settings = {
      outputs = {
        Targets = [ "DP-1" ];
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
            "Tray"
            "Settings"
          ]
        ];
      };

      clock = {
        format = "%H:%M | %e.%m ";
      };

      settings = {
        remove_airplane_btn = true;
      };

      appearance = {
        scale_factor = 1.2;
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

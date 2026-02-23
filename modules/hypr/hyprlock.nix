{ isNixOS, lib, ... }:

{
  programs.hyprlock = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;

    settings = {
      "$font" = "Monospace";

      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 1, 1, 0, 0"
        ];
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          color = "$subtext1";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
    };
  };
}

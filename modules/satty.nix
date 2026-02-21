{ ... }:

{
  programs.satty = {
    enable = true;
    package = null;
    settings = {
      general = {
        fullscreen = true;
        early-exit = true;
        initial-tool = "crop";
        output-filename = "/home/szymon/Obrazy/zrzuty/%d-%m-%Y_%H:%M:%S.png";
        save-after-copy = true;
        disable-notifications = false;
        actions-on-escape = [ "exit" ];
        action-on-enter = "save-to-clipboard";
        no-window-decoration = true;
      };

      color-palette = {
        palette = [
          "#00ffff"
          "#a52a2a"
          "#dc143c"
          "#ff1493"
          "#ffd700"
          "#008000"
        ];

        custom = [
          "#00ffff"
          "#a52a2a"
          "#dc143c"
          "#ff1493"
          "#ffd700"
          "#008000"
        ];
      };
    };
  };
}

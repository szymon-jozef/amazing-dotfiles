{
  lib,
  isNixOS,
  userConfig,
  ...
}:

{
  programs.satty = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;
    settings = {
      general = {
        fullscreen = true;
        early-exit = true;
        initial-tool = "crop";
        output-filename = "/home/${userConfig.username}/Obrazy/zrzuty/%d-%m-%Y_%H:%M:%S.png";
        save-after-copy = true;
        copy-command = "wl-copy";
        disable-notifications = false;
        actions-on-escape = [ "exit" ];
        actions-on-enter = [ "save-to-clipboard" ];
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

{ ... }:

{
  xdg.portal.config = {
    common = {
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      "text/html" = [
        "zen-beta.desktop"
        "zen.desktop"
        "chromium.desktop"
      ];
      "application/xhtml+xml" = [ "zen.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" ];
      "x-scheme-handler/chrome" = [ "zen.desktop" ];
      "application/x-extension-htm" = [ "zen.desktop" ];
      "application/x-extension-html" = [ "zen.desktop" ];
      "application/x-extension-shtml" = [ "zen.desktop" ];
      "application/x-extension-xht" = [ "zen.desktop" ];
      "application/x-extension-xhtml" = [ "zen.desktop" ];

      "audio/*" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];

      "image/*" = [ "org.kde.koko.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];
      "image/svg+xml" = [ "feh.desktop" ];

      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/sgnl" = [ "signal-desktop.desktop" ];
      "x-scheme-handler/tuta" = [ "tutanota-desktop.desktop" ];
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    documents = "$HOME/Dokumenty";
    download = "$HOME/Pobrane";
    music = null;
    pictures = "$HOME/Obrazy";
    videos = "$HOME/Video";
    templates = null;
    publicShare = null;
  };
}

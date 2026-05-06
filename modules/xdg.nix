{ userConfig, ... }:

let
  browserFallback = [
    "zen-beta.desktop"
    "zen.desktop"
    "brave.desktop"
    "chromium.desktop"
  ];
in
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

      "text/html" = browserFallback;
      "application/xhtml+xml" = browserFallback;
      "x-scheme-handler/http" = browserFallback;
      "x-scheme-handler/https" = browserFallback;
      "x-scheme-handler/chrome" = browserFallback;
      "application/x-extension-htm" = browserFallback;
      "application/x-extension-html" = browserFallback;
      "application/x-extension-shtml" = browserFallback;
      "application/x-extension-xht" = browserFallback;
      "application/x-extension-xhtml" = browserFallback;

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
    documents = userConfig.pathConfig.documents;
    download = userConfig.pathConfig.downloads;
    music = null;
    pictures = userConfig.pathConfig.pictures;
    videos = userConfig.pathConfig.video;
    projects = userConfig.pathConfig.projects;
    templates = null;
    publicShare = null;
    setSessionVariables = true;
  };
}

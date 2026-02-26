{ ... }:

let
  mkWebApp =
    {
      name,
      url,
      icon,
      wmClass,
    }:
    {
      inherit name icon;
      genericName = "Web app";
      comment = "Open ${name}";
      exec = "uwsm app -- brave --app=https://${url}";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
        "X-Social"
      ];
      settings = {
        StartupWMClass = wmClass;
      };
    };
in
{

  xdg.desktopEntries = {
    x = mkWebApp {
      name = "X";
      url = "x.com";
      icon = "twitter";
      wmClass = "brave-x.com__-Default";
    };

    proton-mail = mkWebApp {
      name = "Proton-mail";
      url = "mail.proton.me/u/0/inbox.com";
      icon = "proton-mail";
      wmClass = "brave-mail.proton.me__u_0_inbox.com-Default";
    };
  };
}

{ ... }:

{
  xdg.desktopEntries = {
    x = {
      name = "X";
      genericName = "Social Media Client";
      comment = "Open X (twitter)";
      exec = "uwsm app -- chromium --app=https://x.com";
      icon = "twitter";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
        "X-Social"
      ];
    };

    proton-mail = {
      name = "Proton mail";
      genericName = "Proton mail";
      comment = "Open Proton Mail";
      exec = "uwsm app -- chromium --app=https://mail.proton.me/u/0/inbox.com";
      terminal = false;
      categories = [ "Email" ];
      settings = {
        StartupWMClass = "proton-mail.com";
      };
    };
  };
}

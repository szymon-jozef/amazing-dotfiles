{ pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      max-history = 15;
      default-timeout = 5000;
      anchor = "top-right";
      max-visible = 5;
      width = 320;
      height = 300;
      margin = "25,25,10,10";
      padding = 10;
      font = "Cousine Nerd Font mono";
      border-radius = 15;
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#89b4fa";
      progress-color = "over #313244";
      on-notify = "exec paplay /usr/share/sounds/freedesktop/stereo/bell.oga";
    };

    extraConfig = ''
      [urgency=high]
      border-color=#fe640b

      [urgency=low]
      border-color=#FF6347

      [urgency=critical]
      on-notify=exec paplay /usr/share/sounds/freedesktop/stereo/window-attention.oga
      border-color=#FF0000

      [mode=do-not-disturb]
      invisible=1
      on-notify=none

      [app-name=wp-vol]
      layer=overlay
      history=0
      anchor=center
      group-by=app-name
      format=<b>%s</b>\n%b
    '';
  };
}

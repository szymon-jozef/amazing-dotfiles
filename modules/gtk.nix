{ ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.theme = null;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}

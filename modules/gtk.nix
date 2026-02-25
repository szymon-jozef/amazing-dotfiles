{ ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";
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

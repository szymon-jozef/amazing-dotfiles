{
  pkgs,
  pkgs-stable,
  lib,
  userConfig,
  ...
}:

let
  rstudio-with-packages = pkgs-stable.rstudioWrapper.override {
    # we use stable, because unstable is broken rn
    packages = with pkgs-stable.rPackages; [
      # additional packages for rstudio here
      ggplot2
    ];
  };
in

{
  home.packages =
    with pkgs;
    [
      # Cli stuff
      libnotify
      cliphist
      gh
      trash-cli
      pandoc
      fzf
      eza
      fastfetch
      fd
      duf
      gdu
      jq
      tealdeer
      grim
      slurp
      bc
      nh
      runc
      nixfmt
      zathura
      zathuraPkgs.zathura_pdf_mupdf

      # Music
      spotify

      # Gui stuff
      homebank
      gimp
      rstudio-with-packages
      feh
      libreoffice

      # Messaging
      vesktop
      signal-desktop

    ]
    ++ lib.optionals userConfig.gaming [
      mangohud
      prismlauncher
      heroic
      # lutris
      pkgs-stable.rpcs3
      pcsx2
    ];

  xdg.configFile."containers/containers.conf".text = ''
    [engine]
    runtime = "runc"
  '';
}

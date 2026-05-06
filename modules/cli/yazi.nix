{ userConfig, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        mouse_events = [
          "click"
          "scroll"
        ];
        title_format = "Yazi: {cwd}";
      };
    };

    keymap.mgr.prepend_keymap = [
      {
        on = [ "y" ];
        run = [
          "shell -- for path in %s; do echo \"file://$path\"; done | wl-copy -t text/uri-list"
          "yank"
        ];
      }
      {
        on = [
          "g"
          "p"
        ];
        run = "cd ${userConfig.pathConfig.downloads}";
      }
      {
        on = [
          "g"
          "d"
        ];
        run = "cd ${userConfig.pathConfig.documents}";
      }
      {
        on = [
          "g"
          "v"
        ];
        run = "cd ${userConfig.pathConfig.video}";
      }
      {
        on = [
          "g"
          "o"
        ];
        run = "cd ${userConfig.pathConfig.pictures}";
      }
      {
        on = [
          "g"
          "k"
        ];
        run = "cd ${userConfig.pathConfig.projects}";
      }
    ];

    theme.icon.prepend_dirs = [
      {
        name = userConfig.pathConfig.downloads;
        text = "󰉍";
      }
      {
        name = userConfig.pathConfig.documents;
        text = "";
      }
      {
        name = userConfig.pathConfig.video;
        text = "󰕧";
      }
      {
        name = userConfig.pathConfig.pictures;
        text = "󰋩";
      }
      {
        name = userConfig.pathConfig.projects;
        text = "";
      }
    ];
  };
}

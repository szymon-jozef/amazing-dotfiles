{ ... }:

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
    ];
  };
}

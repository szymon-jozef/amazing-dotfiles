{
  isNixOS,
  lib,
  pkgs,
  userConfig,
  ...
}:

{
  programs.obsidian = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;

    defaultSettings = {
      app = {
        vimMode = true;
        alwaysUpdateLinks = true;
        attachmentFolderPath = "media";
        newLinkFormat = "relative";
        newFileLocation = "current";
        useMarkdownLinks = true;
        showUnsupportedFiles = true;
        pdfExportSettings = {
          pageSize = "A4";
          landscape = false;
          margin = "0";
          downscalePercent = 100;
        };
      };

      themes = [
        (pkgs.callPackage ./obsidian-catppuccin.nix { })
      ];

      corePlugins = [
        "file-explorer"
        "global-search"
        "switcher"
        "graph"
        "backlink"
        "canvas"
        "outgoing-link"
        "tag-pane"
        "page-preview"
        "note-composer"
        "command-palette"
        "editor-status"
        "bookmarks"
        "outline"
        "word-count"
        "bases"
      ];
    };

    vaults = {
      "Notatki-szkolne" = {
        target = "${userConfig.pathConfig.obsidian}/notatki-szkolne";
      };
      "Studia" = {
        target = "${userConfig.pathConfig.obsidian}/ZUT-notatki";
      };
    };
  };

}

{
  pkgs,
  userConfig,
  ...
}:

{
  home.packages = with pkgs; [
    git-graph
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = userConfig.fullName;
        email = userConfig.email;
      };
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };

    signing = {
      key = userConfig.email;
      signByDefault = true;
    };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "node_modules"
      "result"
      "__pycache__"
    ];

  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}

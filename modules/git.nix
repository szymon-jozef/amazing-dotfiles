{
  pkgs,
  full_name,
  email,
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
        name = full_name;
        email = email;
      };
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };

    signing = {
      key = email;
      signByDefault = false;
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

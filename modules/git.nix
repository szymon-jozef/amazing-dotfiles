{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-graph
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Szymon P";
        email = "szymon_jozef@proton.me";
      };
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };

    signing = {
      key = "szymon_jozef@proton.me";
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

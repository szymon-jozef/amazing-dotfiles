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
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      pull.rebase = false;
    };

    signing = {
      key = userConfig.signingKey;
      signByDefault = true;
      format = "ssh";
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

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  home.file.".ssh/allowed_signers".text = ''
    ${userConfig.email} ${userConfig.signingKey}
  '';

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}

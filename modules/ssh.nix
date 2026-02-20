{ args, ... }:

{
  services.ssh-agent.enable = true;
  services.ssh-agent.enableFishIntegration = true;

  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks = {
      "dmowski" = {
        hostname = "192.168.0.30";
        user = "szymon";
        port = 22;
        identityFile = "~/.ssh/dmowski";
      };

      "aur.archlinux.org" = {
        user = "szymon";
        identityFile = "~/.ssh/aur";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github";
      };

      "*" = {
        addKeysToAgent = "yes";
        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}

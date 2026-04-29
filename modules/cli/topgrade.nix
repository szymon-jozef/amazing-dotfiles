{ ... }:

let
  system_path = "/etc/nixos";
  home_path = "~/.config/home-manager/";
in
{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "flutter"
          "node"
        ];
        cleanup = true;
      };

      git = {
        repos = [ "$XDG_PROJECTS_DIR/*" ];
      };

      pre_commands = {
        "Git commit before system flake update" =
          "cd ${system_path} && git add -A && git commit --allow-empty -m 'chore: state before system update'";
        "Git commit before home flake update" =
          "cd ${home_path} && git add -A && git commit --allow-empty -m 'chore: state before home update'";
        "Git pull before system flake update " = "cd ${system_path} && git pull";
        "Git pull before home flake update " = "cd ${home_path} && git pull";
      };

      commands = {
        "Update system flake" = "cd ${system_path} && nix flake update";
        "Update home flake" = "cd ${home_path} && nix flake update";
      };

      post_commands = {
        "Git commit after system flake update" =
          "cd ${system_path} && git add -A && git commit --allow-empty -m 'chore: state after system update'";
        "Git commit after home flake update" =
          "cd ${home_path} && git add -A && git commit --allow-empty -m 'chore: state after home update'";
        "Git push system configuration" = "cd ${system_path} && git push";
        "Git push home configuration" = "cd ${home_path} && git push";
      };

    };
  };
}

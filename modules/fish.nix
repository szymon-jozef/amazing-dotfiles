{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      # Dodaje binarki Home Managera do PATH, jeśli jeszcze ich tam nie ma
      fish_add_path --move --prepend --path "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
    '';

    interactiveShellInit = ''
      # no dum greeting
      set fish_greeting ""

      # yes, please setup git for me
      gh auth setup-git

      # add github ssh key
      eval (ssh-agent -c) > /dev/null
      ssh-add ~/.ssh/github 2> /dev/null

      # add github gpg key
      set -gx GPG_TTY (tty)

      # vi mode
      fish_vi_key_bindings

      # Odpalenie fastfetcha na start
      clear
      fastfetch --config ~/.config/fastfetch/startup.jsonc
    '';
  };
}

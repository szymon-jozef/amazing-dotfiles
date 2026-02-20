{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      fish_add_path --move --prepend --path "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
    '';

    interactiveShellInit = ''
      # no dum greeting
      set fish_greeting ""

      # yes, please setup git for me
      gh auth setup-git

      # add github gpg key
      set -gx GPG_TTY (tty)

      # vi mode
      fish_vi_key_bindings

      # Odpalenie fastfetcha na start
      clear
      fastfetch --config ~/.config/fastfetch/startup.jsonc
    '';

    functions = {
      edit_dotfile = {
        description = "Edit config file, reload, commit and push";
        body = ''
          set -l config_dir "$HOME/.config/home-manager"
          set -l file

          if test (count $argv) -gt 0
              set file $argv[1]
          else
              set file (fd . $config_dir --type f --exclude ".git" | fzf)
          end

          if test -n "$file"
              set -l md5_before (md5sum $file)
              
              nvim $file

              if test "$md5_before" != (md5sum $file)
                  echo "Changes made. Prepparing commit..."
                  
                  pushd $config_dir
                  
                  git add $file
                  
                  set -l rel_file (realpath --relative-to=$config_dir $file)
                  
                  set commit_msg "update: $rel_file"
                  git commit -m "$commit_msg"
                  git push
                  
                  home-manager switch -b backup
                  
                  popd
              else
                  echo "No changes made"
              end
          end

        '';
      };

      ls = {
        body = "eza --long --icons --all --group-directories-first --git $argv";
      };
    };
  };
}

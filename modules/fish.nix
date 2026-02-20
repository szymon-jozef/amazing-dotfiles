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

      set -gx GPG_TTY (tty)

      fish_vi_key_bindings

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
              pushd $config_dir
              
              nvim $file

              if test "$md5_before" != (md5sum $file)
                  echo "Changes made. Prepparing commit..."
                  
                  set -l rel_file (realpath --relative-to=$config_dir $file)
                  
                  if home-manager switch -b backup
                      git add -A
                      set commit_msg "update: $rel_file"
                      git commit -m "$commit_msg"
                      git push
                  end

              popd
              else
                  echo "No changes made"
              end
          end

        '';
      };

      ls = {
        body = "eza --long --icons --group-directories-first --git $argv";
      };
    };
  };
}

{ isNixOS, hostName, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = # fish
      ''
        fish_add_path --move --prepend --path "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
      '';

    interactiveShellInit = # fish
      ''
        # no dum greeting
        set fish_greeting ""

        set -gx GPG_TTY (tty)

        fish_vi_key_bindings

        direnv hook fish | source

        fastfetch --config ~/.config/fastfetch/startup.jsonc
      '';

    functions = {
      edit_dotfile = {
        description = "Edit config file, reload, commit and push";
        body = # fish
          ''
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
                    echo "Changes made. Preparing commit..."
                    
                    set -l rel_file (realpath --relative-to=$config_dir $file)
                    
                    if nh home switch $config_dir
                        git add -A
                        set commit_msg "update: $rel_file"
                        git commit -m "$commit_msg"
                        git push
                    end
                else
                    echo "No changes made"
                end
                popd 
            end
          '';
      };

      reload_dotfiles = {
        body = # fish
          "nh home switch ~/.config/home-manager";
      };

      reload_system = {
        body = # fish
          "nh os switch /etc/nixos/";
      };

      cp_mail = {
        body = # fish
          "pandoc $argv -t html |wl-copy -t text/html";
      };

      update = {
        body =
          if isNixOS then
            # fish
            ''
              echo "=== System packages update==="
              pushd /etc/nixos
              git add -A
              git commit -m "before system update"
              nix flake update
              if test $status -eq 0
                  git add ./flake.lock
                  git commit -m "flake lock update"
                  reload_system 
              else
                  echo "Error while updating system flake!"
              end
              popd

              echo "===User packages update==="
              pushd $HOME/.config/home-manager
              git add -A
              git commit -m "before home-manager update"
              nix flake update
              if test $status -eq 0
                  git add ./flake.lock
                  git commit -m "flake lock update"
                  reload_dotfiles
              else
                  echo "Error while updating home flake!"
              end
              popd

              if type -q flatpak
                  echo "===Flatpak update==="
                  flatpak update --noninteractive
                  echo "===Flatpak remove unused==="
                  flatpak uninstall --unused
              end
            ''
          else
            # fish
            ''
              echo "===System update==="

              if not type -q yay
                echo "Yay not found… Please consider installing it!"
              else
                yay
              end

              if type -q pacman
                  echo "===Remove orphans==="
                  set orphans (pacman -Qtdq)
                  if test (count $orphans) -gt 0
                      sudo pacman -Rns $orphans
                  end
              end

              if type -q flatpak
                  echo "===Flatpak update==="
                  flatpak update --noninteractive
                  echo "===Flatpak remove unused==="
                  flatpak uninstall --unused
              end

              if type -q nix-channel
                  echo "===Nix update==="
                  nix-channel --update
                  echo "===Nix garbage collection==="
                  home-manager expire-generations "-7 days"
              end
            '';
      };
    };
    shellAliases = {
      ls = "eza --long --icons --group-directories-first --git";
      lst = "eza --long --icons --color --git --tree";
      rm = "trash";
    };
  };
}

{ isNixOS, ... }:

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
                    
                    if nh home switch $config_dir -c ${
                      if isNixOS then "nixos" else "arch"
                    }" -b backup
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

      ls = {
        body = # fish
          "eza --long --icons --group-directories-first --git $argv";
      };

      lst = {
        body = # fish
          "eza --long --icons --color --git --tree  $argv";
      };

      cp_mail = {
        body = # fish
          "pandoc $argv -t html |wl-copy -t text/html";
      };

      update = {
        body = # fish
          ''
            echo "===System update==="

            if not type -q yay
              echo "Yay not found… Is this Arch? If yes, then please consider installing it!"
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

      rm = {
        body = "trash $argv";
      };

      open = {
        body = "nohup xdg-open $argv > /dev/null & ";
      };

    };
  };
}

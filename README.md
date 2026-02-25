![Nix](https://img.shields.io/badge/Nix-unstable-blue.svg?logo=nixos&logoColor=white)
![Home Manager](https://img.shields.io/badge/Home_Manager-enabled-brightgreen.svg)
# My even cooler than previous dotfiles!
My dotfiles managed with [home manager](https://github.com/nix-community/home-manager), using [catppuccin mocha](https://catppuccin.com/palette/) color scheme!

# What's inside?
* Ashell
* Atuin
* Bat
* Btop
* Fish
* Git
* Hypridle
* Hyprland
* Hyprlauncher
* Hyprlock
* Hyprsunset
* Hyprtoolkit
* Kitty
* Mako
* Nixvim
* Satty
* SSH
* Waybar
* Yazi
* Zoxide
* Fastfetch
* GTK 3.0
* GTK 4.0
* MangoHud
* Mimeapps
* Catppuccin
* Home Manager

## Screenshot
![Desktop screenshot](assets/screenshot.png)
![Terminal screenshot](assets/terminal.png)

# Some history about my dotfiles
My first ever [dotfiles](https://github.com/szymon-jozef/dotfiles) repo was just named… Dotfiles. It was pretty bare bones.

Then I created [superior dotfiles](https://github.com/szymon-jozef/superior_dotfiles). I used it with [chezmoi](https://www.chezmoi.io/). It was pretty good, but then I decided to try something else…

As of today I'm using this repo with home manager. I'm still trying stuff out, but it looks pretty good right now.

# How to use this?
You need to have [home manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) installed. Install needs to be **standalone**. It may not work as NixOS module.
## Settings
You need to edit `flake.nix` to match your preferences.
- If you want to use git, login with `gh auth login`, generate ssh key and put the pub key in the flake. 
- You also need to set your git credentials there
- You can change the path of wallpaper dir.

### Arch Linux
0. If you're extra lazy you can use `install_nix_and_home_manager_on_arch.sh` script to install nix and home-manager. Just run it with `chmod +x ./install_nix_and_home_manager_on_arch.sh && ./install_nix_and_home_manager_on_arch.sh`
1. Copy this repo to `~/.config/home-manager` or somewhere else.
2. Make sure to change variable to your liking inside `flake.nix`. Especially your username and home path!
3. Download all the dependencies `yay -Syu --needed - < arch_packages.txt`. You can use any other aur helper if you want to, but be aware that regular pacman most likely won't work as `ashell` is not in regular repos yet.
4. Run this command to apply all the configurations for the first time `home-manager switch --flake .#arch -b backup`. Make sure to be in the repo root. All your existing files will be backed up with `.backup` extension.
5. Enjoy! Now you can use [nh](https://github.com/nix-community/nh). So for example to switch use `nh home switch . -c arch --backup-extension backup`

### NixOS
1. Copy this repo to `~/.config/home-manager` or somewhere else.
2. Make sure to change variable to your liking inside `flake.nix`. Especially your username and home path!
3. Run this command to apply all the configurations for the first time `home-manager switch --flake .#nixos -b backup`. Make sure to be in the repo root. All your existing files will be backed up with `.backup` extension.
4. Enjoy! Now you can use [nh](https://github.com/nix-community/nh). So for example to switch use `nh home switch . -c nixos --backup-extension backup`

 
**ALSO MAKE SURE TO ENABLE HYPRLAND SYSTEM WIDE!!!!**
```nix
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
```

---

I hope you'll enjoy it, if you for whatever reason want to try this random ass dotfiles found on the internet…

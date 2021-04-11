# Config Files

## Dependencies

### Arch-based

* Install packages from a list
```
sudo pacman -S --needed - < dependencies/pacman_list.txt
```
https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Install_packages_from_a_list

* Download ttf files and put into `~/.local/share/fonts/` https://github.com/romkatv/powerlevel10k#manual-font-installation
* Change default shell to zsh
```
chsh -s /bin/zsh
```

* *optional* Install yay and AUR packages from a list
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --needed - < dependencies/pacman_aur_list.txt
```

### macOS

* Install homebrew
* Disable unidentified developer warning:
```
sudo spctl --master-disable
```
* Install ttf files: https://github.com/romkatv/powerlevel10k#manual-font-installation
* Use homebrew to install dependencies
```
xargs brew install < dependencies/brew_list.txt
xargs brew install --cask < dependencies/brew_cask_list.txt
```

## Installation

* Run install script:
```
./install.sh
```
* *optional* Start sway
* Start kitty terminal, configure powerlevel10k theme
* Install vim-plug for vim/neovim: https://github.com/junegunn/vim-plug
* Install vim plugins in vim/neovim using `:PlugInstall`

## Update dependency files

### Arch-based

```
pacman -Qqen > dependencies/pacman_list.txt
pacman -Qqem > dependencies/pacman_aur_list.txt
```
https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#List_of_installed_packages

### macOS
```
brew leaves > dependencies/brew_list.txt
brew list --cask > dependencies/brew_cask_list.txt
```

## Theme

The PaperColor theme for the kitty terminal emulator is copied from https://github.com/craffate/papercolor-kitty and has a small modification.

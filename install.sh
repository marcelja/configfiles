#!/bin/bash

SWAY_BG_IMAGE=~/pr/bgs/palms.jpg
SWAY_OUTPUT_SCALE=1
SWAY_FONT_SIZE=14

case `uname` in
	Darwin)
		KITTY_MOD=cmd
		KITTY_MOD2=alt
		KITTY_FONT_SIZE=16
		KITTY_FONT_FAMILY="MesloLGS NF"
		DEFAULT_EDITOR=nvim
	;;
	Linux)
		KITTY_MOD=alt
		KITTY_MOD2=cmd
		KITTY_FONT_SIZE=20
		KITTY_FONT_FAMILY="Source Code Pro"
		DEFAULT_EDITOR=nvim
	;;
esac

configspath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
mkdir -p ~/.config/configfiles

install_kitty_config() {
	mkdir -p ~/.config/kitty
	ln -sfn $configspath/kitty ~/.config/kitty/kitty.conf

	echo "
	font_size $KITTY_FONT_SIZE
	font_family $KITTY_FONT_FAMILY
	kitty_mod $KITTY_MOD
	" > ~/.config/configfiles/kitty
}

install_themes() {
	# dark/light themes
	mkdir -p ~/.config/configfiles/profiles
	# bat config is updated to apply dark/light profile
	mkdir -p ~/.config/bat
	$configspath/profiles/dark.sh
	ln -sfn $configspath/profiles/dark.sh ~/.config/configfiles/profiles
	ln -sfn $configspath/profiles/light.sh ~/.config/configfiles/profiles
	ln -sfn $configspath/profiles/papercolor_kitty_dark.conf ~/.config/configfiles/profiles
	ln -sfn $configspath/profiles/papercolor_kitty_light.conf ~/.config/configfiles/profiles
}

install_zsh_config() {
	ln -sfn $configspath/zshrc ~/.zshrc
	echo "
	export EDITOR='$DEFAULT_EDITOR'
	alias vi='$DEFAULT_EDITOR'
	alias vim='$DEFAULT_EDITOR'
	" > ~/.config/configfiles/zsh
}

install_vim_config() {
	# vim
	mkdir -p ~/.vim
	mkdir -p ~/.vimundo
	# nvim
	mkdir -p ~/.config/nvim
	ln -sfn $configspath/vimrc ~/.config/nvim/init.vim
	# nvim lua
	mkdir -p ~/.config/nvim/lua
	ln -sfn $configspath/lsp.lua ~/.config/nvim/lua/lsp.lua
}

install_kitty_config
install_themes
install_zsh_config
install_vim_config

install_sway_configs() {
	# sway
	mkdir -p ~/.config/sway
	ln -sfn $configspath/sway ~/.config/sway/config
	# status.sh
	ln -sfn $configspath/status.sh ~/.config/configfiles
	# mako
	mkdir -p ~/.config/mako
	ln -sfn $configspath/mako ~/.config/mako/config

	echo "
	set \$mod Mod4
	set \$modr Mod1
	output * scale $SWAY_OUTPUT_SCALE
	set \$lockimage $SWAY_BG_IMAGE
	set \$bgimage $SWAY_BG_IMAGE
	font SourceCodePro Medium $SWAY_FONT_SIZE
	" > ~/.config/configfiles/sway
}

install_vim_plug() {
	# nvim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim +PlugInstall +qall
}

install_git_delta() {
	if ! grep -Fq "delta" ~/.gitconfig
	then
		echo "
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[diff]
    colorMoved = default

[delta]
    navigate = true
    syntax-theme=GitHub
  ; line-numbers=true
  ; side-by-side=true
" >> ~/.gitconfig
	fi
}

install_sway_configs
install_vim_plug
install_git_delta

#!/bin/bash

KITTY_MOD=cmd
KITTY_MOD2=alt
SWAY_BG_IMAGE=~/pr/backgrounds/img/08.jpg
SWAY_OUTPUT_SCALE=1.5
SWAY_FONT_SIZE=14

case `uname` in
	Darwin)
		KITTY_FONT_SIZE=16
		KITTY_FONT_FAMILY="MesloLGS NF"
		DEFAULT_EDITOR=vim
	;;
	Linux)
		KITTY_FONT_SIZE=14
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

	# https://github.com/kovidgoyal/kitty/issues/264#issuecomment-355577668
	map $KITTY_MOD2+backspace send_text all \x17
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
	ln -sfn $configspath/vimrc ~/.vimrc
	# nvim
	mkdir -p ~/.config/nvim
	ln -sfn $configspath/vimrc ~/.config/nvim/init.vim
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
	set \$mod Mod1
	set \$modr Mod4
	output * scale $SWAY_OUTPUT_SCALE
	set \$lockimage $SWAY_BG_IMAGE
	set \$bgimage $SWAY_BG_IMAGE
	font SourceCodePro Medium $SWAY_FONT_SIZE
	" > ~/.config/configfiles/sway
}
install_sway_configs

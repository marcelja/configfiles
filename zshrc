if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh configuration from install.sh
source ~/.config/configfiles/zsh

# signed commits
export GPG_TTY=$(tty)

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# mouse scroll with less
export LESS=-asrRix8

# setting title based on active directory
precmd() {
  c=$(echo $PWD | rev | cut -d'/' -f1 | rev)
  b=$(echo $PWD | rev | cut -d'/' -f2 | rev)
  echo -ne "\033]0;"${b:0:1}/$c"\007"
}

# cd into directory after using lf
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

### Aliases

alias lf=lfcd
alias k=kubectl
alias o=openvpn3
alias s=systemctl
alias p="sudo pacman"
alias kssh="kitty +kitten ssh"

alias li='~/.config/configfiles/profiles/light.sh'
alias da='~/.config/configfiles/profiles/dark.sh'

alias g=git
alias gst="git status"
alias gco="git checkout"

alias l="ls -altrh"
alias ll="ls -altrh"
setopt auto_cd

case `uname` in
  Darwin)
    alias ls="ls -G"
  ;;
  Linux)
    alias ls="ls --color"
  ;;
esac

### Completion

zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

source <(kubectl completion zsh)

### Keybindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

# https://superuser.com/a/585004
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

bindkey '^R' history-incremental-search-backward
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

### Plugins

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.zsh ] && . /usr/share/autojump/autojump.zsh
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme ] && . /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ] && . /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

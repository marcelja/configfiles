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
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY

# mouse scroll with less
# export LESS=-asrRix8
export LESS=-si
export DELTA_PAGER='less -R'

# use fd instead of find for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export MANPAGER='nvim +Man!'

# firefox wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export GDK_DPI_SCALE=1.5

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
alias pm=pulsemixer
alias kssh="kitty +kitten ssh"

alias li='~/.config/configfiles/profiles/light.sh'
alias da='~/.config/configfiles/profiles/dark.sh'

alias g=git
alias gst="git status"
alias gco="git checkout"

alias l="exa"
# alias ls="exa"
setopt auto_cd

alias ll="exa --long --color auto --header --git --git-ignore"
alias la="exa --long --color auto --header --git --all"

### Completion

zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

alias kns="kubens -"
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
# alt arrow
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
# ctrl arrow
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# ctrl backspace
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
# do not delete entire directory as one word
autoload -U select-word-style
select-word-style bash

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'
alias ........='../../../../../../..'
alias .........='../../../../../../../..'
alias ..........='../../../../../../../../..'
alias ...........='../../../../../../../../../..'
alias ............='../../../../../../../../../../..'
alias .............='../../../../../../../../../../../..'
alias ..............='../../../../../../../../../../../../..'
alias ...............='../../../../../../../../../../../../../..'
alias ................='../../../../../../../../../../../../../../..'

### Plugins

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme ] && . /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f /usr/share/autojump/autojump.zsh ] && . /usr/share/autojump/autojump.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ] && . /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:~/pr/kotlin-language-server/server/build/install/server/bin:~/.local/bin

# https://superuser.com/questions/1160777/make-special-characters-available-on-us-keyboard-an-wayland
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=altgr-intl

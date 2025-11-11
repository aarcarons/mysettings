export LANG=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='code --wait --new-window'

# omz
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git alias-tips)
source $ZSH/oh-my-zsh.sh
export UPDATE_ZSH_DAYS=14
export DISABLE_UPDATE_PROMPT=true # accept updates by default

# Load local settings
_ZSH_LOCAL_SETTING="$HOME/.zshrc.local"
if [ -f $_ZSH_LOCAL_SETTING ]; then
    source $_ZSH_LOCAL_SETTING
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Shell history
eval "$(hstr --show-configuration)"
## This options are mutually exclusive: INC_APPEND_HISTORY, SHARE_HISTORY and INC_APPEND_HISTORY_TIME
## Setting INC_APPEND_HISTORY_TIME, which will cause the shell to append each command to the history after it completes
## Local tab history (up key) will be kept local
## hstr will read from the history file so it will show commands typed in all tabs
## see https://askubuntu.com/questions/23630/how-do-you-share-history-between-terminals-in-zsh
## https://github.com/dvorka/hstr/issues/400
## https://github.com/ohmyzsh/ohmyzsh/issues/2537
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME


# PATH exports
PATH="$HOME/source/mysettings/scripts:$PATH"
##  Override mac tools with GNU versions (installed via brew)
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/curl/bin:$PATH"
    PATH="$BREW_PREFIX/opt/make/libexec/gnubin:$PATH"
    PATH="$BREW_PREFIX/opt/binutils/bin:$PATH"
fi
PATH="$HOME/.poetry/bin:$PATH"

export PATH

# Load custom functions
if [[ -f "$HOME/source/mysettings/functions.inc" ]]; then
	source "$HOME/source/mysettings/functions.inc"
else
	echo >&2 "WARNING: can't load shell functions"
fi


source ~/.zshrc_aliases

# https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$BREW_PREFIX/opt/asdf/libexec/asdf.sh"
# 1password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
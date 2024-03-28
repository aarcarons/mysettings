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
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
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
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/curl/bin:$PATH"
PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
PATH="/usr/local/opt/binutils/bin:$PATH"
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
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
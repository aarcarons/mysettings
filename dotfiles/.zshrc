# Initialize
export ZSH=$HOME/.oh-my-zsh
export EDITOR='code'
ZSH_THEME="robbyrussell"
plugins=(git osx alias-tips z)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# z
. /usr/local/etc/profile.d/z.sh

# Environment variables
export LANG=en_US.UTF-8
export TERM=xterm-256color

# Bash aliases
source ~/.zshrc_aliases

# Load local settings
_ZSH_LOCAL_SETTING="$HOME/.zshrc.local"
if [ -f $_ZSH_LOCAL_SETTING ]; then
    source $_ZSH_LOCAL_SETTING
fi


# Override mac tools with GNU versions (installed via brew)
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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

[ -d "$HOME/.sc-tools" ] && source "$HOME/.sc-tools/dotfiles/env.zsh" #sc-tools-setup

export PATH="$HOME/.poetry/bin:$PATH"

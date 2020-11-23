# Initialize
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git osx)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

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
export LANG=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='code --wait --new-window'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline --preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null" --preview-window=right:60% --bind "ctrl-j:down,ctrl-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-l:toggle-preview"'


# Load local settings
_ZSH_LOCAL_SETTING="$HOME/.zshrc.local"
if [ -f $_ZSH_LOCAL_SETTING ]; then
    source $_ZSH_LOCAL_SETTING
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# PATH exports
PATH="$HOME/source/mysettings/scripts:$PATH"
PATH="$HOME/.local/bin:$PATH"

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

source "$BREW_PREFIX/opt/asdf/libexec/asdf.sh"

# 1password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Atuin (history/search)
eval "$(atuin init zsh)"

source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

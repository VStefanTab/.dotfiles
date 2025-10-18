# Set path if required
#export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
# ~/.zshrc

eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)

# History
setopt inc_append_history
setopt share_history
setopt histignorealldups sharehistory
# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history


# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias ec="$EDITOR $HOME/.zshrc"  # edit .zshrc
alias sc="source $HOME/.zshrc"  # reload zsh configuration
if command -v bat &>/dev/null; then
  alias fzf='fzf --preview="bat --color=always {}"'
fi
alias clr='clear'

# Ensure no alias conflicts
unalias cf 2>/dev/null

# Define the function cd with fzf
cf() {
  local dir
  dir=$(find . -type d | fzf --preview="ls -lah --color=always {}") && cd "$dir"
}



# Use modern completion system
autoload -Uz compinit
compinit

# zplug - manage plugins
source /usr/share/zplug/init.zsh
#zplug "plugins/git", from:oh-my-zsh
#zplug "plugins/sudo", from:oh-my-zsh
#zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf"

# Install/load new plugins when zsh is started or reloaded
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose
# Press prefix + I (capital i, as in Install) to fetch the plugin.

# Binaries
export PATH="/usr/local/bin:/usr/bin:/bin"  # Add core system paths explicitly
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/BashScript:$PATH"
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -------------------
# zimfw configuration
# -------------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim Framework install

# ~/.zshrc
# Start tmux automatically if not already inside a tmux session
if command -v tmux >/dev/null 2>&1; then
  if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi
fi

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

if command -v nvim &>/dev/null; then
  export EDITOR=nvim
fi

# Aliases
if command -v eza &>/dev/null; then
    alias ls='eza'
    alias ll='eza -la --git --git-repos --header'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
fi

if command -v xclip &>/dev/null; then
    alias "c=xclip"
    alias "v=xclip -o"
fi

if command -v rg  &>/dev/null; then
    alias grep='rg'
else
    alias grep='grep --color=auto'
fi

alias ec="$EDITOR $HOME/.zshrc"  # edit .zshrc
alias sc="source $HOME/.zshrc"  # reload zsh configuration

if command -v bat &>/dev/null; then
  alias fzf='fzf --preview="bat --color=always {}"'
  alias cat='bat --color=always'
fi

if command -v yazi &>/dev/null; then
	alias y='yazi'
fi

alias clr='clear'
alias em="emacs -nw"
# Ensure no alias conflicts
unalias cf 2>/dev/null

# Define the function cd with fzf
cf() {
  local dir
  dir=$(find . -type d | fzf --preview="ls -lah --color=always {}") && cd "$dir"
}

# Use modern completion system
#autoload -Uz compinit
#compinit

# PATH
dirs=(
"$HOME/personal/Installs"
"$HOME/Downloads/LSPs"
"$HOME/BashScripts"
"$HOME/.emacs.d/bin"
"$HOME/personal/Installs/NodeJS/Nodes/out/bin"
"$HOME/personal/Downloads/YAZI/yazi"
"$HOME/.cargo/bin"
"/opt/lua-language-server/lua-language-server/bin"
)
# Function to add only if non-empty and not already in PATH
add_to_path_if_nonempty(){
  local dir="$1"
  if [[ -d "$dir" && -n $(ls -A "$dir" 2>/dev/null) ]]; then
    if [[ ":$PATH:" != *":$dir:"* ]]; then
            export PATH="$dir:$PATH"
    fi
    else
      echo "$dir doesn't exist or is empty"
      echo "$(ls -A "$dir" 2>/dev/null)"
  fi
}

for dir in "${dirs[@]}"; do
  add_to_path_if_nonempty "$dir"
done

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


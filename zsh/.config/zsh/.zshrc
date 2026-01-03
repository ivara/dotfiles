# .zshrc [Read when interactive]
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout
# -----------------------------------------------
# everything needed only for interactive usage
# prompt, command completion, aliases, functions, output coloring, aliases, key bindings
#
#
#
# Choose where to put a setting
# - if it is needed by a command run non-interactively: .zshenv
# - if it should be updated on each new shell: .zshenv
# - if it runs a command which may take some time to complete: .zprofile
# - if it is related to interactive usage: .zshrc
# - if it is a command to be run when the shell is fully setup: .zlogin
# - if it releases a resource acquired at login: .zlogout
# ---------------------------------------------

# autoload -Uz compinit && compinit
#
# # Use a completion menu.
zstyle ':completion:*' menu select

#
# Load completion system
autoload -Uz compinit
compinit

# History settings
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000 # How many commands zsh will load to memory
SAVEHIST=10000 # How many commands history will save on file


# zsh options
setopt no_beep       # disable terminal bell

# When deleting with <C-w>, delete file names at a time.
WORDCHARS=${WORDCHARS/\/}


# Dela history mellan shell-sessioner direkt
setopt INC_APPEND_HISTORY      # Skriv varje kommando till $HISTFILE direkt

# Valfritt, men rekommenderas
# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY


# FZF + history search
__fzf_history_widget() {
  local selected
  selected=$(fc -l 1 | sort -r | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | fzf --tac +s --no-sort --query="$LBUFFER" --height 40% --reverse --prompt="History> ")
  if [[ -n $selected ]]; then
    LBUFFER=$selected
  fi
}
zle -N fzf-history-widget __fzf_history_widget
bindkey '^R' fzf-history-widget  # Ctrl+R to trigger


# Zinit (plugin manager)
source /opt/homebrew/opt/zinit/zinit.zsh
#  load Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# add more common Plugins
#zinit light zsh-users/zsh-history-substring-search

# ------------------------------
# Aliases
# ------------------------------
alias vi="NVIM_APPNAME=nvim-2026 nvim"
alias nvim="NVIM_APPNAME=nvim-2026 nvim"
alias ls="eza --icons"
alias la="eza --icons -a"
alias ll="eza --icons -l"
alias lt="eza --icons --tree --level=2"
alias ltt="eza --icons --tree --level=3"
alias lttt="eza --icons --tree --level=4"
alias ltttt="eza --icons --tree --level=5"
alias bathelp='bat --plain --language=help'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias gdu='gdu-go'

# git stuff
# alias gd="git diff"
# alias gs="git status --short"
# alias gl="git lg"
# alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'

# ------------------------------
# Functions
# ------------------------------
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --layout=reverse --border --exit-0)

  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return

  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

cheat() {
  curl "cheat.sh/$*"
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

rfv() {
	# 1. Search for text in files using Ripgrep
	# 2. Interactively narrow down the list using fzf
	# 3. Open the file in Vim
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
		fzf --ansi \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--delimiter : \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--bind 'enter:become(neovim {1} +{2})'
			# --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
}

check_directory_for_new_repository() {
  current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]; then
    onefetch
  fi
  last_repository=$current_repository
}

cd() {
  builtin cd "$@"
  check_directory_for_new_repository
}

# Fuzzy find and kill listening processes
k() {
  local pid
  pid=$(lsof -i -P -n -u $(whoami) 2>/dev/null | grep LISTEN | \
    fzf --height=70% --reverse --header="Select process to kill (ESC to cancel)" \
        --preview='echo "Process details:"; ps -p $(echo {} | awk "{print \$2}") -o pid,ppid,user,%cpu,%mem,start,command' \
        --preview-window=down:4:wrap | \
    awk '{print $2}')
  
  if [[ -n "$pid" ]]; then
    echo "Killing PID $pid..."
    kill "$pid" && echo "Done." || echo "Failed. Try: kill -9 $pid"
  fi
}

# Zoxide
eval "$(zoxide init zsh)"

# Starship.rs
eval "$(starship init zsh)"

eval "$(direnv hook zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# uncomment this (and first line in this file) to profile what takes time to load in config
# zprof

zinit light zsh-users/zsh-syntax-highlighting # must come last

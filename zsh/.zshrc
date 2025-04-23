# Uncomment this (and last line in file) to profile load times in config
# zmodload zsh/zprof

# ------------------------------
# Homebrew Configuration
# ------------------------------
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
  elif [[ -d "/usr/local" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"  # Intel Mac
  fi
elif [[ "$(uname -r)" == *"Microsoft"* ]]; then
  # WSL
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# ------------------------------
# Aliases
# ------------------------------
# alias vi="NVIM_APPNAME=nvim-lazyvim nvim"
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

help() {
  "$@" --help 2>&1 | bathelp
}

batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}


# ------------------------------
# Environment Variables
# ------------------------------
export EDITOR=nvim
export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:~/.dotnet/tools
export NVM_DIR="$HOME/.nvm"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER=less
# export BAT_PAGER="less"
# export BAT_THEME="Catppuccin Frappe"
export BAT_THEME="Visual Studio Dark+"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top --info=inline'
# get list of files and directories
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# get list of only directories
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza --icons --tree --level=2 {}'"


# Load NVM
# if [[ "$(uname)" == "Darwin" ]]; then
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
# elif [[ "$(uname -r)" == *"Microsoft"* ]]; then
#   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# fi
#
# Docker CLI completions
# fpath=(/Users/ivar/.docker/completions $fpath)

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm, without auto-using the default version

autoload -Uz compinit && compinit

# Zoxide
eval "$(zoxide init zsh)"

# Starship.rs
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# uncomment this (and first line in this file) to profile what takes time to load in config
# zprof


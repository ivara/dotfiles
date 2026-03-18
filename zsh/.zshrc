# .zshrc — single-file zsh configuration
#
# Loaded for every interactive shell. On macOS with terminal emulators
# like Ghostty, every new window/tab is a login + interactive shell,
# so this file is always sourced.

# ── Homebrew (static, no eval) ────────────────────────────────────────
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man:${MANPATH:-}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# ── XDG base directories ─────────────────────────────────────────────
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ── PATH ──────────────────────────────────────────────────────────────
path=(
  $HOME/go/bin                              # Go binaries
  $HOME/.cargo/bin                          # Rust/Cargo
  $HOME/.dotnet/tools                       # dotnet global tools
  /usr/local/share/dotnet                   # .NET SDK
  ${ASDF_DATA_DIR:-$HOME/.asdf}/shims       # asdf
  /opt/homebrew/opt/postgresql@18/bin        # PostgreSQL
  $path
)
typeset -U path   # deduplicate

# ── Environment variables ─────────────────────────────────────────────
export DOTNET_ROOT="/usr/local/share/dotnet"

export NVIM_APPNAME="nvim-2026"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export MANPAGER="nvim +Man!"

export SHELL_SESSIONS_DISABLE=1              # disable macOS save/restore
export GHOSTTY_SHELL_FEATURES="title,sudo"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# Telemetry opt-outs
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1
export AZURE_MCP_COLLECT_TELEMETRY=0
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# fzf theme
export FZF_DEFAULT_OPTS="\
  --color=fg:#f8f8f2,bg:#0e1419,hl:#e11299 \
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#e11299 \
  --color=info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6 \
  --color=marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
  --cycle --pointer=▎ --marker=▎"

# ── Secrets (keep out of git) ─────────────────────────────────────────
[[ -f ~/.secrets ]] && source ~/.secrets

# ── History ───────────────────────────────────────────────────────────
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY          # timestamp + duration in history
setopt HIST_EXPIRE_DUPS_FIRST    # expire dupes first when trimming
setopt HIST_FIND_NO_DUPS         # don't show dupes in search
setopt HIST_IGNORE_ALL_DUPS      # remove older duplicate entries
setopt HIST_IGNORE_SPACE         # ignore commands starting with space
setopt HIST_SAVE_NO_DUPS         # don't write dupes to file
setopt HIST_REDUCE_BLANKS        # trim extra whitespace
setopt SHARE_HISTORY             # share history across sessions

# ── Shell options ─────────────────────────────────────────────────────
setopt no_beep
WORDCHARS=${WORDCHARS/\/}        # Ctrl-W stops at /

# ── Completion (cached — regenerates once per day) ────────────────────
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select

# ── Zinit + plugins ──────────────────────────────────────────────────
source /opt/homebrew/opt/zinit/zinit.zsh
zinit light zsh-users/zsh-completions
zinit wait lucid for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting

# ── fnm (Fast Node Manager) ──────────────────────────────────────────
eval "$(fnm env --use-on-cd)"

# ── Tool inits ────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
source <(fzf --zsh)

# ── Aliases ───────────────────────────────────────────────────────────
alias vi="nvim"
alias ls="eza --icons"
alias la="eza --icons -a"
alias ll="eza --icons -l"
alias lt="eza --icons --tree --level=2"
alias ltt="eza --icons --tree --level=3"
alias lttt="eza --icons --tree --level=4"
alias bathelp="bat --plain --language=help"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias gdu="gdu-go"

# ── Functions ─────────────────────────────────────────────────────────

# Pick a neovim config interactively
vv() {
  local config
  config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename "$config") nvim "$@"
}

# Quick cheat.sh lookup
cheat() { curl "cheat.sh/$*"; }

# Yazi file manager (cd on exit)
y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Ripgrep + fzf + open in nvim
rfv() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --bind 'enter:become(nvim {1} +{2})'
}

# Show onefetch when cd-ing into a new git repo
last_repository=
check_directory_for_new_repository() {
  current_repository=$(git rev-parse --show-toplevel 2>/dev/null)
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
  pid=$(lsof -i -P -n -u "$(whoami)" 2>/dev/null | grep LISTEN | \
    fzf --height=70% --reverse --header="Select process to kill (ESC to cancel)" \
        --preview='echo "Process details:"; ps -p $(echo {} | awk "{print \$2}") -o pid,ppid,user,%cpu,%mem,start,command' \
        --preview-window=down:4:wrap | \
    awk '{print $2}')
  if [[ -n "$pid" ]]; then
    echo "Killing PID $pid..."
    kill "$pid" && echo "Done." || echo "Failed. Try: kill -9 $pid"
  fi
}

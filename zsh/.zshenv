# .zshenv [Read every time]
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout
# -----------------------------------------------
#
# should set environment variables which need to be updated frequently
#

# XDG base directories.
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Make sure this stuff is in the path.
#export PATH="$HOME/.nvim/bin:$PATH" # neovim
#export PATH="$HOME/.cargo/bin:$PATH" # cargo
#export PATH="$HOME/.local/bin:$PATH" # Local scripts.

# zsh configuration.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh" # tell zsh where to look for its config files

# Man pages
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER='nvim +Man!'
export PAGER=less

# Set up neovim as the default editor.
export EDITOR="$(which nvim)"
export VISUAL="$EDITOR"

# Disable Apple's save/restore mechanism.
export SHELL_SESSIONS_DISABLE=1

# Don't let Ghostty mess up with the cursor.
export GHOSTTY_SHELL_FEATURES="title,sudo"

# Ripgrep.
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"

# Lazygit
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# fzf setup.
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#0e1419,hl:#e11299,fg+:#f8f8f2,bg+:#44475a,hl+:#e11299,info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
--cycle --pointer=▎ --marker=▎"

# .NET SDK
export DOTNET_ROOT="/usr/local/share/dotnet"
#export DOTNET_ROOT="/opt/homebrew/share/dotnet"      # Apple Silicon Macs (brew-installed .NET
export PATH="$DOTNET_ROOT:$PATH"
# export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:~/.dotnet/tools


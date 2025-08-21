# .zprofile [Read at login]
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout
# -----------------------------------------------
# for commands and variables which should be set once or which don't need to be updated frequently
#
# https://unix.stackexchange.com/questions/324359/why-a-login-shell-over-a-non-login-shell/324391#324391
#
# Re-read this file by running: exec zsh --login

# Homebrew variables.
if [[ "$(uname -s)" == "Linux" && -d  /home/linuxbrew/.linuxbrew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$(uname -s)" == "Darwin" && -d /opt/homebrew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Fast Node Manager (fnm) setup
if command -v fnm > /dev/null; then
  eval "$(fnm env --use-on-cd)"
fi


# 📑 Dotfiles

## Windows

Use [Scoop](https://scoop.sh/) to install software smoothly on windows.

```pwsh
scoop bucket add extras
scoop bucket add nerd-fonts

scoop install main/bat

scoop install Cascadia-Code
scoop install main/zoxide
scoop install main/fzf
scoop install extras/psfzf
scoop install extras/lazygit
scoop install main/neovim
```

This is how to add symbolic links on windows

1. Open cmd.exe as Administrator
2. `mklink c:\Users\ivara\.vimrc e:\git\dotfiles\.vimrc`
3. `mklink c:\Users\ivara\.gitconfig e:\git\dotfiles\.gitconfig`
4. `mklink c:\Users\ivara\.bashrc e:\git\dotfiles\.bashrc`
5. `mklink c:\Users\ivara\.config\powershell\user_profile.ps1 e:\git\dotfiles\.config\powershell\user_profile.ps1`

Or using i.e. Git bash

1. Open git bash as administrator
2. `ln -s /d/git/dotfiles/.vimrc /c/Users/ivara/.vimrc`
3. `ln -s /d/git/dotfiles/.gitconfig /c/Users/ivara/.gitconfig`
4. `ln -s /d/git/dotfiles/.bashrc /c/Users/ivara/.bashrc`
5. `ls -s /d/git/dotfiles/.config/powershell/user_profile.ps1 /c/Users/ivara/.config/powershell/user_profile.ps1`

### Powershell

1. find out where your config resides `echo $PROFILE.CurrentUserCurrentHost`
2. add this to that file: `. $env:USERPROFILE\.config\powershell\user_profile.ps1`

## Linux

Create your symlinks using `ln`

## Git

[Install delta](https://github.com/dandavison/delta)

```cmd
winget install dandavison.delta
```

For git user you need to create a `~/.gitconfig.user` with

```git
[user]
    name = your name
    email = your.email@domain.com
```

To test if you've got it working you can open a terminal and write `git config user.email` and see if it uses it correctly

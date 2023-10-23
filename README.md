# 📑 Dotfiles



## Windows

This is how to add symbolic links on windows

1. Open cmd.exe as Administrator
2. `mklink c:\Users\ivara\.vimrc d:\git\dotfiles\.vimrc`
3. `mklink c:\Users\ivara\.gitconfig d:\git\dotfiles\.gitconfig`
4. `mklink c:\Users\ivara\.bashrc d:\git\dotfiles\.bashrc`

Or using i.e. Git bash

1. Open git bash as administrator
2. `ln -s /d/git/dotfiles/.vimrc /c/Users/ivara/.vimrc`
3. `ln -s /d/git/dotfiles/.gitconfig /c/Users/ivara/.gitconfig`
4. `ln -s /d/git/dotfiles/.bashrc /c/Users/ivara/.bashrc`

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


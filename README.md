# 📑 .dotfiles



## Windows

This is how to add symbolic links on windows

1. Open cmd.exe as Administrator
2. Write `mklink c:\Users\username\.vimrc d:\git\dotfiles\.vimrc`

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

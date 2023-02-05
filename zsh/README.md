# Zshell Note

## Setup
1. Check the path `$ZDOTDIR` set in `.zshenv`, e.g. `$HOME/.config/zsh`.
2. Create a soft link of the `.zshenv` file, then the configuration will take effect:
```
ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv
```

## Discussion
1. [What should/shouldn't go in .zshenv, .zshrc, .zlogin, .zprofile, .zlogout?](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout)
2. [Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html)

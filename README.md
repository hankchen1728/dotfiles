# Configuration Files
![tmux](./figures/tmux.png)

## Alacritty (terminal)
See [README.md](https://github.com/hankchen1728/dotfiles/blob/main/alacritty/README.md).

## Tmux
See [README.md](https://github.com/hankchen1728/dotfiles/blob/main/tmux/README.md).

## Bash
Source the file `sh/.bashrc`:
```sh
source sh/.bashrc
```

## Zsh
Source the file `sh/.zshrc`:
```sh
source sh/.zshrc
```

## Neovim
See [README.md](https://github.com/hankchen1728/dotfiles/blob/main/nvim/README.md).

## Installation
Shell script for installing **python3** from source `installation/install_python3.sh`

Also containing some tools, e.g. `vim`, `tmux`, `fish`

## Check NVIDIA GPU Environment
1. CUDA
```sh
$ nvcc --version | grep "release" | awk '{print $6}'
# V10.1.243
```
2. CUDnn
```sh
$ locate cudnn | grep "libcudnn.so." | tail -n1 | sed -r 's/^.*\.so\.//'
# 7.6.5
```
3. NCCL
```sh
$ locate nccl | grep "libnccl.so" | tail -n1 | sed -r 's/^.*\.so\.//'
# 2.4.8
```

## Deprecated
#### Fish shell
Put the file `Deprecated/fish/config.fish` at the path `${HOME}/.config/fish/config.fish`

#### Vim
See [README.md](https://github.com/hankchen1728/dotfiles/blob/main/Deprecated/vim/README.md).

## Future Work

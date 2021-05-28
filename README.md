# Configuration Files

## Bash
```
./bash/.bashrc
```

## vim
```
./vim/.vimrc
```

#### 1. About ```virtualenv``` on ```vim```
First add the following line to `.vimrc` ,
```
let g:virtualenv_directory = $VIRTUAL_ENV
```

and then link virtual environments path to `$VIRTUAL_ENV`
```
$ ln -s <Virtualenv_PATH> ${VIRTUAL_ENV}/<Virtualenv_NAME>
```

## Neovim
```
./nvim/init.vim
```

## source
```
/source/.source
```

## Installation
Shell scripts install **python3** from source
```
/installation/install_python3.sh
```

## Check NVidia GPU Environment
1. CUDA 8.0, 9.0, 9.1, 10.0
```sh
$ nvcc --version | grep "release" | awk '{print $6}'
# V10.1.243
```
2. CUDnn 6+, 7+
```sh
$ locate cudnn | grep "libcudnn.so." | tail -n1 | sed -r 's/^.*\.so\.//'
# 7.6.5
```
3. NCCL 2.0+
```sh
$ locate nccl | grep "libnccl.so" | tail -n1 | sed -r 's/^.*\.so\.//'
# 2.4.8

## Future Work

# Configuration for vim

## Python3 Supoort

### 1. Python Support
First make sure that `vim` has `python3` support by calling
```sh
$ vim --version
```
to see if has the flag `+python3`

If no python3 support, please reinstall vim, for **macOS**,
```sh
$ brew install vim --with-python3
```
for linux, see [install_vim.sh](https://github.com/hankchen1728/dotfiles/blob/master/installation/install_vim.sh).

### 2. Autocompletion and Syntax Checking
- Autocompletion tool [jedi-vim](https://github.com/davidhalter/jedi-vim) requires the python library `jedi`
```sh
$ pip3 install jedi
```

- Syntax check tool [ALE](https://github.com/dense-analysis/ale) requires some libraries, such as `flake8`, `pylint`, `autopep8`, see [here](https://github.com/dense-analysis/ale#5xviii-how-can-i-configure-ale-differently-for-different-buffers) to see how the specify the **linters** and **fixers** for **python3**

### 3. About ```virtualenv``` on ```vim```
First add the following line to `.vimrc` ,
```vim
let g:virtualenv_directory = $VIRTUAL_ENV
```

and then link virtual environments path to `$VIRTUAL_ENV`
```sh
$ ln -s <Virtualenv_PATH> ${VIRTUAL_ENV}/<Virtualenv_NAME>
```
Therefore you are able to switch the python *virtualenv* within **vim**
```vim
:VirtualEnvActivate <Virtualenv_NAME>
```

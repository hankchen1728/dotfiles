# Configuration Files

## Bash
```
/bash/.bashrc
```

## vim
```
/vim/.vimrc
```

### 1. About ```virtualenv``` on ```vim```

First add the following line to ```.vimrc``` ,
```
let g:virtualenv_directory = $VIRTUAL_ENV
```
and then link virtual environments path to ```$VIRTUAL_ENV```
```
$ ln -s <Virtualenv_PATH> ${VIRTUAL_ENV}/<Virtualenv_NAME>
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

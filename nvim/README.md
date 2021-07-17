# Configuration Neovim

## Installation
1. Installing **neovim** 0.5+, downloaded from [Github release](https://github.com/neovim/neovim/releases/).
2. Installing [ Packer.nvim ](https://github.com/wbthomason/packer.nvim) and required language servers
```sh
$ bash install.sh
```
3. Installing one of the patched [ Nerd-Fonts ](https://github.com/ryanoasis/nerd-fonts#patched-fonts)

## Known Issues
#### 1. LSP automatically Start
<img src="./figures/nvim-py-lsp.png" height="120"/>

If the **LSP** cannot automatically start as the nvim start, the following might solve the issue
1. In `init.vim`, replace the `syntax on` by
```vim
syntax enable
```
2. Call the command `:e` or `:Lspstart` *within nvim*, add the following line to `init.vim`
```vim
autocmd BufEnter ?* if index(blacklist, &ft) < 0 | LspStart
```

## TODOs
Add more informations!

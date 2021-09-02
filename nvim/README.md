# Configuration Neovim

## Installation
1. Installing **neovim** 0.5+, downloaded from [Github release](https://github.com/neovim/neovim/releases/).
2. Installing [ Packer.nvim ](https://github.com/wbthomason/packer.nvim) and required language servers
```sh
bash install.sh
```
3. Installing one of the patched [ Nerd-Fonts ](https://github.com/ryanoasis/nerd-fonts#patched-fonts)

## Plugins
Run `nvim +PackerSync` to install or upgrade plugins

### Syntax Highlight
- Using [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- (Optional) Installing **tree-sitter-cli** via `cargo`:
```sh
cargo install tree-sitter-cli --git https://github.com/tree-sitter/tree-sitter.git --tag v0.20.0
```

### Autocompletion
1. Engine: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), work with *nvim-cmp* sources:
    - [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) for neovim **Lua API**
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) for for neovim builtin **LSP client**
    - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) for **buffer** words
    - [cmp-path](https://github.com/hrsh7th/cmp-path) for **filesystem paths**
    - [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip) for [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
2. LSP: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
3. Snippets: [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
    - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) for more useful snippets

### Formatter
- Using [Neoformat](https://github.com/sbdchd/neoformat)
- With formatters:
    - python: `autopep8`
    - C++: `clang-format`

### Statusline
1. Switching from **vim-airline** to [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
2. Starting from some [ awesome examples ](https://github.com/glepnir/galaxyline.nvim/issues/12)
3. Choosing fancy icons with [nerd-fonts](https://www.nerdfonts.com/cheat-sheet)

## Known Issues
### LSP Automatically Startup
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

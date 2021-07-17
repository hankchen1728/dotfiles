-- Only required if you have packer configured as `opt`
local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    config = vim.cmd [[
      nnoremap <F1> :NvimTreeToggle<CR>
      let g:nvim_tree_highlight_opened_files = 1
      let g:nvim_tree_auto_open = 1
    ]]
  }

  -- statusline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'tpope/vim-fugitive'               -- git helper for vim
  use {
    "akinsho/nvim-bufferline.lua",
    config = [[ require"nvim-bufferline" ]],
  }
  -- use "glepnir/galaxyline.nvim"

  -- Colorscheme and highlight
  use 'navarasu/onedark.nvim'
  use {
    'blueyed/vim-diminactive',     -- dim inactive windows
    config = vim.cmd [[
        " disable syntax highlight in inactive pane
        " let g:diminactive_use_syntax = 1
        hi ColorColumn ctermbg=236 guibg=#eee8d5
    ]]
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = require('colorizer').setup()
  }

  -- Helper tools
  use 'google/vim-searchindex'           -- Search index helper

  -- for alignment
  use 'AndrewRadev/splitjoin.vim'
  use {
   'junegunn/vim-easy-align',
    config = vim.cmd [[
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
    ]]
  }
  use {
    'FooSoft/vim-argwrap',        -- Wrap and unwrap function arguments, lists, and dictionaries in Vim.
    config = vim.cmd [[
      nnoremap <silent> <Space>a :ArgWrap<CR>
    ]]
  }
  use {
    'Yggdroot/indentLine',
    config = vim.cmd [[
      let g:indentLine_enabled = 0
      "let g:indentLine_setColors = 0
      let g:indentLine_color_term = 50
      let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    ]]
  }
  use {
    'scrooloose/nerdcommenter',
    config = vim.cmd [[
      " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims            = 1

      let g:NERDCommentEmptyLines      = 0

      " Use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs        = 1

      " Enable trimming of trailing whitespace when uncommenting
      let g:NERDTrimTrailingWhitespace = 1

      " Align line-wise comment delimiters flush left instead of following code indentation
      let g:NERDDefaultAlign           = 'left'

      let g:NERDCustomDelimiters       = {'c':{'left':'//'}, 'python':{'left':'#'}, 'bash':{'left':'#'}}

      " Use <Backspace> to toggle comment
      nmap <BS> <plug>NERDCommenterToggle
      vmap <BS> <plug>NERDCommenterToggle
    ]]
  }

  -- LSP and auto completion
  use {
    'neovim/nvim-lspconfig',
    config = [[ require"nvim-lspconfig" ]],
    event = "BufRead",
  }
  use {
    "onsails/lspkind-nvim",
    event = "BufRead",
    config = function()
      require("lspkind").init()
    end
  }

  use {
    'hrsh7th/nvim-compe',
    event = "InsertEnter",
    config = [[ require'nvim_compe' ]]
  }

  -- Formatter
  use {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    config = [[ require"neoformat" ]]
  }

  -- tag viewer
  use {
    "liuchengxu/vista.vim",
    config = vim.cmd[[
      let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
      let g:vista_default_executive = "nvim_lsp"

      " toggle Vista window
      nnoremap <space>v :Vista!!<CR>
    ]]
  }

  use "kyazdani42/nvim-web-devicons"

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/popup.nvim"},
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    },
    config = [[ require"nvim-telescope" ]]
  }

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup()
    end
  }
  use {
    'tpope/vim-surround',
    config = vim.cmd [[
      let g:surround_no_mappings = 1
      nmap cs <Plug>Csurround
      nmap ds <Plug>Dsurround
      vmap s  <Plug>VSurround
      vmap gs <Plug>VgSurround
    ]]
  }

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = "BufRead",
    config = function()
      require('treesitter').config()
    end
  }

  -- Markdown
  use {
    'godlygeek/tabular',
    ft = "markdown"
  }
  use {
    'plasticboy/vim-markdown',
    ft = "markdown",
    config = vim.cmd [[
      let g:vim_markdown_toc_autofit      = 1
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_no_default_key_mappings = 1
    ]]
  }
  use {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    run = ":call mkdp#util#install()",
    config = vim.cmd [[
      " do NOT automatically open the preview window
      let g:mkdp_auto_start = 0

      " auto close current preview window when change to another buffer
      let g:mkdp_auto_close = 1

      " auto refresh markdown as you edit or move the cursor
      let g:mkdp_refresh_slow = 0

      " preview server available to others in your network
      let g:mkdp_open_to_the_world = 1

      " custom the server ip
      " let g:mkdp_open_ip = system("curl ifconfig.me")

      " use a custom port to start server
      let g:mkdp_port = '8017'

      " echo preview page url in command line when open preview page
      let g:mkdp_echo_preview_url = 1

      " preview page title, default with filename
      let g:mkdp_page_title = '「${name}」'
    ]]
  }
  use 'iamcco/mathjax-support-for-mkdp'       -- mathjax support for markdown-preview.vim plugin

end)

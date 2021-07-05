-- Only required if you have packer configured as `opt`
local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- statusline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'tpope/vim-fugitive'               -- git helper for vim
  -- use "akinsho/nvim-bufferline.lua"
  -- use "glepnir/galaxyline.nvim"

  -- auto pair brackets
  use {
    'jiangmiao/auto-pairs',
    config = vim.cmd [[
      let g:AutoPairsShortcutBackInsert = ''
      let g:AutoPairsShortcutToggle = "<leader>p"
      let g:AutoPairsMapCR = 1
    ]]
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

  -- Colorscheme and highlight
  use 'joshdick/onedark.vim'
  use {
    'blueyed/vim-diminactive',     -- dim inactive windows
    config = vim.cmd [[
        " disable syntax highlight in inactive pane
        " let g:diminactive_use_syntax = 1
        hi ColorColumn ctermbg=236 guibg=#eee8d5
    ]]
  }
  use 'google/vim-searchindex'           -- Search index helper
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
    ]]
  }

  -- LSP and auto completion
  use {
    'neovim/nvim-lspconfig',
    event = "BufRead",
    config = [[ require"nvim-lspconfig" ]]
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

  use "kyazdani42/nvim-web-devicons"

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
      let g:mkdp_auto_start = 0 				  " do NOT automatically open the preview window
      let g:mkdp_auto_close = 1 				  " auto close current preview window when change to another buffer
      let g:mkdp_refresh_slow = 0  			  " auto refresh markdown as you edit or move the cursor
      let g:mkdp_command_for_global = 0         " MarkdownPreview command can be use for only markdown file
      let g:mkdp_open_to_the_world = 1   		  " preview server available to others in your network
      let g:mkdp_open_ip = system("curl ifconfig.me")  " custom the server ip
      let g:mkdp_port = '8017'                  " use a custom port to start server
      let g:mkdp_browser = ''                   " no browser specified
      let g:mkdp_echo_preview_url = 1           " echo preview page url in command line when open preview page
      let g:mkdp_browserfunc = ''               " custom vim function name to open preview page
      let g:mkdp_page_title = '「${name}」'     " preview page title, default with filename
    ]]
  }
  use 'iamcco/mathjax-support-for-mkdp'       -- mathjax support for markdown-preview.vim plugin

  -- CSV
  use {
    'chrisbra/csv.vim',
    config = vim.cmd [[
      let g:csv_no_progress = 1
      let g:csv_strict_columns = 1
      let g:csv_start = 1
      let g:csv_end = 100
      let g:csv_nomap_up=1
      let g:csv_nomap_down=1
    ]]
  }


end)

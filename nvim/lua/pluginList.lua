-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
local use = packer.use

return packer.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme and highlight
  use {
    'navarasu/onedark.nvim',
    config = function ()
      vim.g.onedark_style = 'cool'
      vim.g.onedark_transparent_background = true
      require("onedark").setup()
      require "highlights"
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  use "kyazdani42/nvim-web-devicons"

  -- browser
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = "NvimTreeToggle",
    config = vim.cmd [[
      nnoremap <F1> :NvimTreeToggle<CR>
      let g:nvim_tree_highlight_opened_files = 1
      let g:nvim_tree_auto_open = 0
    ]]
  }

   --statusline
  use {
    "glepnir/galaxyline.nvim",
    after = "onedark.nvim",
    config = function ()
      require "plugins.statusline"
    end
  }
  use {
    "akinsho/nvim-bufferline.lua",
    config = function ()
      require "plugins.bufferline"
    end
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

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end
  }

  -- LSP and auto completion
  use {
    'neovim/nvim-lspconfig',
    config = function ()
      require "plugins.lspconfig"
    end
  }
  use {
    "onsails/lspkind-nvim",
    event = "BufRead",
    config = function()
      require("lspkind").init()
    end
  }

  -- completion
  use {
    'hrsh7th/nvim-compe',
    event = "InsertEnter",
    config = function ()
      require "plugins.compe"
    end
  }

  -- autopairs
  use {
    "windwp/nvim-autopairs",
    after = "nvim-compe",
    config = function()
        require "plugins.autopairs"
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

  -- Formatter
  use {
    "sbdchd/neoformat",
    cmd = "Neoformat",
    config = function ()
      require "plugins.neoformat"
    end
  }

  -- tag viewer
  use {
    "liuchengxu/vista.vim",
    after = "nvim-lspconfig",
    config = vim.cmd[[
      let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
      let g:vista_default_executive = "nvim_lsp"

      " toggle Vista window
      nnoremap <space>v :Vista!!<CR>
    ]]
  }

-- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    after = "plenary.nvim",
    config = function()
      require('gitsigns').setup()
    end
  }

  -- telescope
  use {
    "nvim-lua/plenary.nvim",
    event = "BufRead"
  }
  use {
    "nvim-lua/popup.nvim",
    after = "plenary.nvim"
  }

  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.telescope"
    end
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    cmd = "Telescope"
  }

  -- markdown-preview
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

  -- helper
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  }

end)

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
local use = packer.use

return packer.startup(function()
  -- Packer can manage itself
  use {
    'wbthomason/packer.nvim',
    event = "VimEnter"
  }

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
    config = function()
      vim.g.nvim_tree_highlight_opened_files = 1
      vim.g.nvim_tree_auto_open = 0
    end
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

  -- for alignment
  use 'AndrewRadev/splitjoin.vim'
  use 'junegunn/vim-easy-align'
  use 'FooSoft/vim-argwrap'
  use {
    'Yggdroot/indentLine',
    config = function ()
	    vim.g.indentLine_enabled = 0
      vim.g.indentLine_color_term = 50
      vim.g.indentLine_char_list = { '|', '¦', '┆', '┊' }
    end
  }
  use {
    'scrooloose/nerdcommenter',
    config = function ()
      -- Create default mappings
      vim.g.NERDCreateDefaultMappings  = 0
      -- Add spaces after comment delimiters by default
      vim.g.NERDSpaceDelims            = 1
      vim.g.NERDCommentEmptyLines      = 0
      -- Use compact syntax for prettified multi-line comments
      vim.g.NERDCompactSexyComs        = 1
      -- Enable trimming of trailing whitespace when uncommenting
      vim.g.NERDTrimTrailingWhitespace = 1
      -- Align line-wise comment delimiters flush left instead of following code indentation
      vim.g.NERDDefaultAlign           = 'left'
      vim.g.NERDCustomDelimiters       = {c = {left='//'}, python = {left='#'}, bash = {left='#'}}
    end
  }

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate',
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

  -- completion: switch to nvim-cmp
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require "plugins.cmp"
    end,
  }
  use {
    'hrsh7th/vim-vsnip',
    after = "nvim-cmp",
  }
  use {
    'hrsh7th/vim-vsnip-integ',
    after = "vim-vsnip"
  }
  use {
    "rafamadriz/friendly-snippets",
    after = "vim-vsnip"
  }

  -- extra source for nvim-cmp
  use {
    "hrsh7th/cmp-nvim-lua",
    after = "nvim-cmp"
  }
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }
  use {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  }
  use {
    "hrsh7th/cmp-path",
    after = "nvim-cmp"
  }
  use {
    "hrsh7th/cmp-vsnip",
    after = "cmp-buffer"
  }

  -- autopairs
  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require "plugins.autopairs"
    end
  }
  use {
    'tpope/vim-surround',
    config = function ()
	    vim.g.surround_no_mappings = 1
    end
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
    event = "BufRead",
    config = function()
      vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
      vim.g.vista_default_executive = "nvim_lsp"
    end
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
    run = "make"
  }

  -- markdown-preview
  use {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    run = ":call mkdp#util#install()",
    config = function ()
      -- do NOT automatically open the preview window
      vim.g.mkdp_auto_start = 0
      -- auto close current preview window when change to another buffer
      vim.g.mkdp_auto_close = 1
      -- auto refresh markdown as you edit or move the cursor
      vim.g.mkdp_refresh_slow = 0
      -- preview server available to others in your network
      vim.g.mkdp_open_to_the_world = 1
      -- custom the server ip
      -- g.mkdp_open_ip = system("curl ifconfig.me")
      -- use a custom port to start server
      vim.g.mkdp_port = '8017'
      -- echo preview page url in command line when open preview page
      vim.g.mkdp_echo_preview_url = 1
      -- preview page title, default with filename
      vim.g.mkdp_page_title = '「${name}」'
    end
  }

  -- helper
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  }

end)

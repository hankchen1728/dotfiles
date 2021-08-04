local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local set_map = vim.api.nvim_set_keymap

local opt = {}

-- Package custom keymaps
-- vim-easy-align
set_map("n", "ga", "<Plug>(EasyAlign)", opt)
set_map("x", "ga", "<Plug>(EasyAlign)", opt)

-- vim-argwrap
map("n", "<Space>a", ":ArgWrap<CR>", opt)

-- nerdcommenter
set_map("n", "<BS>", "<Plug>NERDCommenterToggle", opt)
set_map("v", "<BS>", "<Plug>NERDCommenterToggle", opt)

-- vim-surround
set_map("n", "cs", "<Plug>Csurround", opt)
set_map("n", "ds", "<Plug>Dsurround", opt)
set_map("v",  "s", "<Plug>VSurround", opt)
set_map("v", "gs", "<Plug>VgSurround", opt)
set_map("x",  "s", "<Plug>VSurround", opt)
set_map("x", "gs", "<Plug>VgSurround", opt)

-- NvimTree toggle window
map("n", "<F1>", ":NvimTreeToggle<CR>", opt)

-- Vista
map("n", "<space>v", ":Vista!!<CR>", opt)

-- Telescope
map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)
map("n", "<Leader>gt", ":Telescope git_status <CR>", opt)
map("n", "<Leader>cm", ":Telescope git_commits <CR>", opt)
map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<Leader>fp", ":Telescope media_files <CR>", opt)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)

-- Packer commands till because we are not loading it at startup
vim.cmd("silent! command PackerCompile lua require 'pluginList' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'pluginList' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'pluginList' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'pluginList' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'pluginList' require('packer').update()")

-- nvim compe
-- use tab to navigate completion menu
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

function _G.completions()
  local npair_present, npairs = pcall(require, "nvim-autopairs")
  if not npair_present then
      return
  end

  if vim.fn.pumvisible() == 1 then
      if vim.fn.complete_info()["selected"] ~= -1 then
          return vim.fn["compe#confirm"]("<CR>")
          -- return vim.fn["compe#complete"](npairs.autopairs_cr())
      end
  end
  return npairs.check_break_line_char()
end

-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true, noremap = true})
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true, noremap = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true, noremap = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, noremap = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, noremap = true})

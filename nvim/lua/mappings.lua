local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local set_map = vim.api.nvim_set_keymap

local opt = {}

-- builtin matchit
set_map("n", "g[", "<Plug>(MatchitNormalMultiBackward)", opt)
set_map("n", "g]", "<Plug>(MatchitNormalMultiForward)", opt)

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

-- neoformat
map("n", "<Leader>fm", ":Neoformat<CR>", opt)

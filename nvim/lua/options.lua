local opt = vim.opt
local g = vim.g

-- function for concatenates path components to a path string
-- Executes like `os.path.join`
local function path_join(...)
  local is_windows = vim.loop.os_uname().version:match 'Windows'
  local path_sep = is_windows and '\\' or '/'
  -- local path_sep = package.config:sub(1, 1)

  local result = table.concat(
    vim.tbl_flatten { ... }, path_sep
  ):gsub(path_sep .. '+', path_sep)
  return result
end

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

-- disable nvim intro
opt.shortmess:append "sI"

-- Setting custom snippet file path
g.vsnip_snippet_dir = path_join(vim.fn.stdpath("config"), "snips")

-- disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

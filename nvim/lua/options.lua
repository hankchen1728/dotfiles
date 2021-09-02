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
vim.cmd("let &fcs='eob: '")

-- Setting custom snippet file path
vim.g.vsnip_snippet_dir = path_join(vim.fn.stdpath("config"), "lua", "snips")

-- disable some builtin vim plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  -- "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- local present, ts_config = pcall(require, "nvim-treesitter.configs")
-- if not present then
--   return
-- end

local ts_config = require"nvim-treesitter.configs"

ts_config.setup {
  ensure_installed = {
    "comment",
    "toml",
    "bash",
    "c",
    "cpp",
    "lua",
    "python",
    "vim",
    "verilog",
  },
  highlight = {
    enable = true,
    use_languagetree = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

require'bufferline'.setup{
  highlights = {
    buffer_selected = {
      guifg = "#ff5f00",
      gui = "bold,italic"
    },
  },
  options = {
    offsets = {{filetype = "NvimTree", text = "File Explorer"}},
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    max_name_length = 25,
    separator_style = "thin",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
          or (e == "warning" and " " or "" )
        s = s .. n .. sym
      end
      return s
    end,
  }
}

vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "L", ":BufferLineMoveNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "H", ":BufferLineMovePrev<CR>", {silent = true})

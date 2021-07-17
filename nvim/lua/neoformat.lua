-- Set formatter for python
vim.g.neoformat_enabled_python = {'autopep8', 'yapf', 'docformatter'}
vim.g.neoformat_python_autopep8 = {
  exe = "autopep8",
  args = {'-v', '--max-line-length=79'},
  replace = 0,  -- do not replace the file, only write to buffer
}


-- run a formatter on save
-- vim.api.nvim_command([[
-- augroup fmt
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
-- ]])

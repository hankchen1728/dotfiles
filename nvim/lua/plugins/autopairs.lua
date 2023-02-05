local present1, autopairs = pcall(require, "nvim-autopairs")
local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
local present_cmp, cmp = pcall(require, "cmp")

if not (present1 or present2 or present_cmp) then
  return
end

autopairs.setup({
  map_cr = true
})
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

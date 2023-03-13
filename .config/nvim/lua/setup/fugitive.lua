local fugitive = vim.api.nvim_create_augroup("fugitive", {
  clear = true
})
vim.api.nvim_create_autocmd("BufReadPost", {
  group = fugitive,
  pattern = "fugitive://*",
  command = "set bufhidden=delete"
})

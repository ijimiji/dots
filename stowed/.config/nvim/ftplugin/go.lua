local ok, go = pcall(require, "go")
if not ok then
  return
end

require('go').setup()

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = vim.api.nvim_create_augroup("GoFormat", { clear = true}),
})

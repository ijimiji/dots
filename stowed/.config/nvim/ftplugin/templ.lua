vim.lsp.start({
  name = "templls",
  cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/tmp/templ.log" },
  root_dir = vim.fs.dirname(vim.fs.find({'go.mod'}, { upward = true })[1]),
})

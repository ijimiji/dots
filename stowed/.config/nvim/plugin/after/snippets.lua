local ok, snippets = pcall(require, "luasnip.loaders.from_vscode")
if ok then
	snippets.lazy_load({ exclude = { "tex" } })
end

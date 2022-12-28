local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

ts.setup({
	ensure_installed = { "go", "lua", "cpp", "python" },
	auto_install = true,
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
	},
})

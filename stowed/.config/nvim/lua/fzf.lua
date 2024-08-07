local ok, fzf = pcall(require, "fzf-lua")
if not ok then
	return
end

fzf.setup({
	fzf_colors = {
		fg = { "fg", "CursorLine" },
		bg = { "bg", "Normal" },
		hl = { "bg", "IncSearch" },
		["fg+"] = { "fg", "Normal" },
		["bg+"] = { "bg", "CursorLine" },
		["hl+"] = { "bg", "IncSearch" },
		info = { "fg", "PreProc" },
		prompt = { "fg", "Conditional" },
		pointer = { "fg", "Exception" },
		marker = { "fg", "Keyword" },
		spinner = { "fg", "Label" },
		header = { "fg", "Comment" },
		gutter = { "bg", "Normal" },
	},
	winopts = {
		win_border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
		height = 0.9, 
		width = 0.9,
		preview = {
			wrap = "nowrap",
			hidden = "hidden",
		},
	},
})

vim.keymap.set("n", "<C-p>", require("fzf-lua").files)
vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
vim.keymap.set("n", "<M-x>", require("fzf-lua").commands)
vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
vim.keymap.set("n", "<M-s>", require("fzf-lua").live_grep)
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix)
vim.keymap.set("n", "<C-x><C-f>", require("fzf-lua").files)
vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
vim.keymap.set("n", "<C-r>", require("fzf-lua").resume)

vim.keymap.set({"n"}, "<C-]>", require("fzf-lua").buffers)
vim.keymap.set({"n"}, "<C-[>", require("fzf-lua").quickfix)

fzf.register_ui_select()

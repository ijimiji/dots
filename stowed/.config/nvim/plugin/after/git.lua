vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gp", function()
	vim.cmd("Git push")
end)

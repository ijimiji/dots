local ok, dap = pcall(require, "dap")
if not ok then
	return
end

local ok, ui = pcall(require, "dapui")
if not ok then
	return
end

local ok, dap_go = pcall(require, "dap-go")
if not ok then
	return
end

ui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "right",
		},
	},
})

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
	{
		name = "Just this file",
		type = "codelldb",
		request = "launch",
		cwd = '${workspaceFolder}',
		program = function()
			vim.fn.system("g++ " .. vim.fn.expand("%") .. " -g --std=c++20 -o main")
			return "main"
		end,
		stopOnEntry = false,
	},
	{
		name = "Specific file (compile on your own)",
		type = "codelldb",
		request = "launch",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/main", "file")
		end,
		stopAtEntry = true,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap_go.setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	delve = {
		initialize_timeout_sec = 20,
		port = "${port}",
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "@", texthl = "ErrorMsg" })
vim.fn.sign_define("DapStopped", { text = "->", texthl = "GitSignsAdd" })

vim.keymap.set({ "n", "i" }, "<F9>", dap.toggle_breakpoint)
vim.keymap.set({ "n", "i" }, "<F5>", dap.continue)
vim.keymap.set({ "n", "i" }, "<F17>", function()
	dap.continue()
	ui.toggle({})
end)

vim.keymap.set("n", "<leader>du", ui.toggle)

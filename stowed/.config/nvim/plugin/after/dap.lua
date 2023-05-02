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

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7"
}

dap.configurations.cpp = {
	{
		name = "Just this file",
		type = "cppdbg",
		request = "launch",
		program = function()
			vim.fn.system("g++ " .. vim.fn.expand("%") .. " -g --std=c++20 -o main")
			return "main"
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = true
			},
		},
	},
	{
		name = "Specific file (compile on your own)",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/main", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = true
			},
		},
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

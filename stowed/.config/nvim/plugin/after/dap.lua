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

dap_go.setup({
	dap_configurations = {
		{
			-- Must be "go" or it will be ignored by the plugin
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

vim.fn.sign_define("DapBreakpoint", { text = "⏺" })

vim.keymap.set({ "n", "i" }, "<F9>", dap.toggle_breakpoint)
vim.keymap.set({ "n", "i" }, "<F5>", dap.continue)
vim.keymap.set({ "n", "i" }, "<F17>", function()
	dap.continue()
	ui.toggle({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end)

vim.keymap.set("n", "<leader>du", ui.toggle)
local hl = vim.api.nvim_set_hl

hl(0, "DapUIVariable", { link = "Normal" })
hl(0, "DapUIScope", { link = "Normal" })
hl(0, "DapUIType", { link = "Normal" })
hl(0, "DapUIValue", { link = "Normal" })
hl(0, "DapUIModifiedValue", { link = "Normal" })
hl(0, "DapUIDecoration", { link = "Normal" })
hl(0, "DapUIThread", { link = "Normal" })
hl(0, "DapUIStoppedThread", { link = "Normal" })
hl(0, "DapUIFrameName", { link = "Normal" })
hl(0, "DapUISource", { link = "Normal" })
hl(0, "DapUILineNumber", { link = "Normal" })
hl(0, "DapUIFloatNormal", { link = "Normal" })
hl(0, "DapUIFloatBorder", { link = "Normal" })
hl(0, "DapUIWatchesEmpty", { link = "Normal" })
hl(0, "DapUIWatchesValue", { link = "Normal" })
hl(0, "DapUIWatchesError", { link = "Normal" })
hl(0, "DapUIBreakpointsPath", { link = "Normal" })
hl(0, "DapUIBreakpointsInfo", { link = "Normal" })
hl(0, "DapUIBreakpointsCurrentLine", { link = "Normal" })
hl(0, "DapUIBreakpointsLine", { link = "Normal" })
hl(0, "DapUIBreakpointsDisabledLine", { link = "Normal" })
hl(0, "DapUICurrentFrameName", { link = "Normal" })
hl(0, "DapUIStepOver", { link = "Normal" })
hl(0, "DapUIStepInto", { link = "Normal" })
hl(0, "DapUIStepBack", { link = "Normal" })
hl(0, "DapUIStepOut", { link = "Normal" })
hl(0, "DapUIStop", { link = "Normal" })
hl(0, "DapUIPlayPause", { link = "Normal" })
hl(0, "DapUIRestart", { link = "Normal" })
hl(0, "DapUIUnavailable", { link = "Normal" })

local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                -- "breakpoints",
                -- "stacks",
                -- "watches",
            },
            size = 4,
            position = "bottom",
        },
    },
})

dap.adapters.go_remote = function(callback, config)
    vim.defer_fn(
    function()
        callback({type = "server", host = config.host, port = config.port})
    end,
    100)
end

dap.adapters.go = {
    type = "server",
    port = "8080",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:8080" },
    },
}

vim.fn.sign_define("DapBreakpoint", { text = "@", texthl = "ErrorMsg" })
vim.fn.sign_define("DapStopped", { text = "->", texthl = "GitSignsAdd" })

vim.keymap.set("n", "<F9>",       dap.toggle_breakpoint)
vim.keymap.set("n", "<F5>",       dap.continue)
vim.keymap.set("n", "<F10>",      dap.step_over)
vim.keymap.set("n", "<F11>",      dap.step_into)
vim.keymap.set("n", "<F23>",      dap.step_out)
vim.keymap.set("n", "<leader>du", dapui.toggle)

dap.configurations.go = {
    {
        type = "go_remote",
        name = "Attach remote Shedevrum",
        mode = "remote",
        request = "attach",
        program = "",
        substitutePath = {
            {
                to = "/-S", 
                from = "/Users/larynjahor/arcadia",
            }, 
        },
	host = "shedevrum-dev-larynjahor.sas.yp-c.yandex.net",
        port = "2345"
    },
    {
        type = "go_remote",
        name = "Stuff",
    }
}
local control_hl_groups = {
    "DapUINormal",
    "DapUIVariable",
    "DapUIScope",
    "DapUIType",
    "DapUIValue",
    "DapUIModifiedValue",
    "DapUIDecoration",
    "DapUIThread",
    "DapUIStoppedThread",
    "DapUIFrameName",
    "DapUISource",
    "DapUILineNumber",
    "DapUIFloatNormal",
    "DapUIFloatBorder",
    "DapUIWatchesEmpty",
    "DapUIWatchesValue",
    "DapUIWatchesError",
    "DapUIBreakpointsPath",
    "DapUIBreakpointsInfo",
    "DapUIBreakpointsCurrentLine",
    "DapUIBreakpointsLine",
    "DapUIBreakpointsDisabledLine",
    "DapUICurrentFrameName",
    "DapUIStepOver",
    "DapUIStepInto",
    "DapUIStepBack",
    "DapUIStepOut",
    "DapUIStop",
    "DapUIPlayPause",
    "DapUIRestart",
    "DapUIUnavailable",
    "DapUIWinSelect",
    "DapUIEndofBuffer",
}



for _, hl in ipairs(control_hl_groups) do
    vim.api.nvim_set_hl(0, hl, {link = "Default"})
end

require("nvim-dap-virtual-text").setup()

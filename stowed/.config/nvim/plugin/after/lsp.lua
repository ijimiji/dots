local autocmd = vim.api.nvim_create_autocmd
local au      = vim.api.nvim_create_augroup

autocmd("LspAttach", {
    group = au("lspmaps", { clear = true }),
    callback = function(args)

        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = vim.g.terminal_color_3 })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = vim.g.terminal_color_3 })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = vim.g.terminal_color_3 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.b.formatexpr = vim.lsp.formatexpr()
        vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = vim.api.nvim_create_augroup("GoFormat", { clear = true}),
})


local lspconfig = require("lspconfig")
lspconfig.gopls.setup {
    config = {
        --cmd = {"/Users/larynjahor/.ya/tools/v4/gopls-darwin-arm64/gopls"},
        build = {
            expandWorkspaceToModule = false,
            env  = {
                CGO_ENABLED = "0",
                GOFLAGS = "-mod=vendor",
                GOPRIVATE = "*.yandex-team.ru,*.yandexcloud.net"
            }
        },
        formatting = {
            ["local"] =  "a.yandex-team.ru",
        },
        settings = {
            gopls = {
                expandWorkspaceToModule = false,
                directoryFilters = filters,
                analyses = {
                    atomic = true,
                    unusedparams = true, 
                    unusedwrite = true, 
                    shadow = true,
                    defer = true,
                },
                staticcheck = true,
            },
        },
    }
}

local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
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

dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = function()
            local argument_string = vim.fn.input "Path to binary: "
            vim.notify("Debugging binary: " .. argument_string)
            return vim.fn.split(argument_string, " ", true)[1]
        end,
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

vim.o.softtabstop    = 4
vim.b.softtabstop    = 4

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = vim.api.nvim_create_augroup("GoFormat", { clear = true}),
})

vim.lsp.start({
  name = "gopls",
  cmd = {"gopls"},
  root_dir = vim.fs.dirname(vim.fs.find({'go.mod'}, { upward = true })[1]),
})

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
    type = "go_remote",
    name = "Attach remote Shedevrum",
    mode = "remote",
    request = "attach",
    program = "/Users/larynjahor/arcadia/yy/backend/masterpiecer/cmd/masterpiecer/masterpiecer",
    substitutePath = {
      {
        to = "/-S", 
        from = "/Users/larynjahor/arcadia",
      }, 
    },

    host =  "shedevrum-dev-larynjahor.sas.yp-c.yandex.net",
    port = "2345"
  },
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

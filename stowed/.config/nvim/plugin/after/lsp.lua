local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set

require("mason").setup({})

require("mason-tool-installer").setup({
	ensure_installed = {
		"staticcheck",
		"golangci-lint",
		"goimports",
		"golines",
	},
	run_on_start = true,
	start_delay = 0,
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"rust_analyzer",
		"pyright",
		"texlab",
		"gopls",
	},
	automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
	function(server)
		require("lspconfig")[server].setup({})
	end,
})

require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

function goto_next_error()
	if #vim.fn.getqflist() == 0 then
		vim.diagnostic.goto_next({ float = { border = "single" } })
	else
		vim.cmd("try | cnext | catch | cfirst | catch | endtry")
	end
end

function goto_prev_error()
	if #vim.fn.getqflist() == 0 then
		vim.diagnostic.goto_prev({ float = { border = "single" } })
	else
		vim.cmd("try | cprev | catch | clast | catch | endtry")
	end
end

map("n", "<C-j>", goto_next_error)
map("n", "<C-k>", goto_prev_error)

autocmd("LspAttach", {
	group = augroup("lspmaps", { clear = true }),
	callback = function(args)
		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "gi", vim.lsp.buf.implementation)
		map("n", "<space>r", vim.lsp.buf.rename)
		map("n", "<space>ca", vim.lsp.buf.code_action)
		map("n", "gr", require("fzf-lua").lsp_references)
	end,
})

vim.fn.sign_define("LightBulbSign", { text = "蛍", texthl = "Todo" })

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.diagnostics.staticcheck.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity["WARN"]
			end,
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		}),

		-- null_ls.builtins.diagnostics.golangci_lint.with({
		-- 	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		-- }),

		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false })
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false })
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = vim.g.terminal_color_3 })
		vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = vim.g.terminal_color_3 })
		vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = vim.g.terminal_color_3 })
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

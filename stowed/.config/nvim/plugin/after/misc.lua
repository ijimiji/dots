require('mini.completion').setup()
require('mini.align').setup({mappings = { start_with_preview = "ga" }})
require('mini.comment').setup()
require("mini.surround").setup({mappings = { replace = "cs" }})
require("nvim-autopairs").setup()
require("fidget").setup({progress = { display = { done_icon = "!"}}})

do
  local ok, fzf = pcall(require, "fzf-lua")
  if not ok then
    return
  end

  fzf.setup({
    files = {
      git_icons = false,
      file_icons = false,
    },
    fzf_opts = { ["--color"] = "16" },
    winopts = {
      win_border = "single",
      height = 0.9, 
      width = 0.9,
      preview = {
        hidden = "hidden",
        wrap   = "nowrap",
      },
    },
  })

  local function resume(fn) 
    return function()
      return fn({resume = true})
    end
  end

  vim.keymap.set("n", "<C-p>",      resume(require("fzf-lua").files))
  vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
  vim.keymap.set("n", "<M-x>",      require("fzf-lua").commands)
  vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
  vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
  vim.keymap.set("n", "<M-s>",      require("fzf-lua").live_grep)
  vim.keymap.set("n", "<leader>b",  require("fzf-lua").buffers)
  vim.keymap.set("n", "<leader>q",  require("fzf-lua").quickfix)
  vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
  vim.keymap.set("n", "<C-r>",      require("fzf-lua").resume)

  -- vim.keymap.set("n", "<C-]>",      require("fzf-lua").buffers)
  -- vim.keymap.set("n", "<C-[>",      require("fzf-lua").quickfix)

  vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
  vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations)

  fzf.register_ui_select()
end



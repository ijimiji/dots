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

local function cwd(fn) 
    return function()
        return fn({cwd_only = true})
    end
end

vim.keymap.set("n", "<C-p>",      require("fzf-lua").files, {noremap = true})
vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
vim.keymap.set("n", "<M-x>",      require("fzf-lua").commands)
vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
vim.keymap.set("n", "<M-s>",      require("fzf-lua").live_grep)
vim.keymap.set("n", "<leader>b",  require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>D",  cwd(require("fzf-lua").diagnostics_workspace))
vim.keymap.set("n", "<leader>q",  require("fzf-lua").quickfix)
vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
vim.keymap.set("n", "<C-r>",      require("fzf-lua").resume)

vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations)

fzf.register_ui_select()

local highlights = {
    "FzfLuaNormal",
    "FzfLuaBorder",
    "FzfLuaTitle",
    "FzfLuaHelpNormal",
    "FzfLuaHelpBorder",
    "FzfLuaPreviewNormal",
    "FzfLuaPreviewBorder",
    "FzfLuaPreviewTitle",
    "FzfLuaCursor",
    "FzfLuaCursorLine",
    "FzfLuaCursorLineNr",
    "FzfLuaSearch",
    "FzfLuaScrollBorderEmpty",
    "FzfLuaScrollBorderFull",
    "FzfLuaScrollFloatEmpty",
    "FzfLuaScrollFloatFull",
    "FzfLuaHeaderBind",
    "FzfLuaHeaderText",
    "FzfLuaBufName",
    "FzfLuaBufNr",
    "FzfLuaBufLineNr",
    "FzfLuaBufFlagCur",
    "FzfLuaBufFlagAlt",
    "FzfLuaTabTitle",
    "FzfLuaTabMarker",
    "FzfLuaDirIcon",
    "FzfLuaLiveSym",
}


for _, a in pairs(highlights) do
    vim.api.nvim_set_hl(0, a, { link = "default"})
end




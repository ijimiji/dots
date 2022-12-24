require('fzf-lua').setup{
    border = "single",
    fzf_colors = {
        fg          = { "fg", "CursorLine" },
        bg          = { "bg", "Normal" },
        hl          = { "bg", "Search" },
        ["fg+"]         = { "fg", "Normal" },
        ["bg+"]         = { "bg", "CursorLine" },
        ["hl+"]         = { "bg", "Search" },
        info        = { "fg", "PreProc" },
        prompt      = { "fg", "Conditional" },
        pointer     = { "fg", "Exception" },
        marker      = { "fg", "Keyword" },
        spinner     = { "fg", "Label" },
        header      = { "fg", "Comment" },
        gutter      = { "bg", "Normal" },
    },
    winopts = {
        preview = {
            wrap = "nowrap",
            hidden = "hidden",
        },
    }
}

vim.keymap.set("n", "<C-p>", require('fzf-lua').files)
vim.keymap.set("n", "<leader>fF", require('fzf-lua').builtin)
vim.keymap.set("n", "<M-x>", require('fzf-lua').commands)
vim.keymap.set("n", "<leader>fh", require('fzf-lua').help_tags)
vim.keymap.set("n", "<leader>fH", require('fzf-lua').highlights)
vim.keymap.set("n", "<M-s>", require('fzf-lua').live_grep)
vim.keymap.set("n", "<leader>b", require('fzf-lua').buffers)

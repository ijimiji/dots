local luasnip = require("luasnip")
local cmp = require'cmp'

local sources = {
    { name = "nvim_lsp" }, 
    { name = "luasnip" }, 
    { name = "buffer" },
    { name = "path" },
}


-- vim.keymap.set("c", "<C-n>", cmp.select_next_item)
-- vim.keymap.set("c", "<C-p>", cmp.select_prev_item)

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        documentation = cmp.config.window.bordered({
            border = "single"
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

    }),
    sources = cmp.config.sources(sources)
})

return function(backends, icons, snippet)
    local sources = {}

    for _, source in ipairs(backends) do
        table.insert(sources, { name = source })
    end

    local cmp = require("cmp")
    local kind_icons = icons 

    cmp.setup {
        snippet = { expand = snippet },
        sources = cmp.config.sources(sources), 
        mapping = { 
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<C-n>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end
            }),
            ['<C-p>'] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end
            }),
        }, 
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                return vim_item
            end
        }
    }

    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        })
    })

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    return capabilities
end


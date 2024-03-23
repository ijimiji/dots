require('mini.align').setup({mappings = { start_with_preview = "ga" }})
require('mini.comment').setup()
require("mini.surround").setup({mappings = { replace = "cs" }})
require("nvim-autopairs").setup()
require("fidget").setup({
    progress = { 
        display = { 
            done_icon = "!",
            done_style = "@attribute",
            icon_style = "@attribute",
            group_style = "@attribute",
            progress_style = "@attribute",
        },
},
})
require('tabout').setup({})

-- require('mini.completion').setup()

local snippets = require("luasnip.loaders.from_vscode")
snippets.lazy_load({ exclude = { "tex" } })

do
  local luasnip = require("luasnip")
  local cmp     = require('cmp')

  cmp.setup({
    view = {
      docs = {
        auto_open = true
      }
    },
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
      ["<C-y>"]      = cmp.mapping.confirm({
          select = false,
          behavior = cmp.ConfirmBehavior.Insert,
      }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ["<Tab>"]     = cmp.mapping(function(fallback)
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
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, 
      { name = "luasnip" }, 
      { name = "buffer" },
      { name = "path" },
    })
  })
end


require'lsp_signature'.setup({
    bind = true,
    hint_enable = false,
    handler_opts = {
        border = "single"
    },
      hi_parameter = "@comment.todo",
})

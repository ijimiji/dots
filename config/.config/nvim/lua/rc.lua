require "vanilla.options"
require "plugins.packer"
require "plugins.comment"
require "maps.common"

local snippets   = require("plugins.snippets")
local completion = require("plugins.cmp")({"nvim_lsp", "vsnip", "buffer"}, snippets)
local signs      = require("plugins.signs")({Error = "◍", Warn = "◍", Hint = "◍", Info = "◍", Lightbulb = "◍"})
local ui = require("plugins.lsp-ui")

require("plugins.lsp-installer")({"clangd", "texlab", "pyright"}, completion, ui)

vim.cmd [[
let $BAT_THEME = 'Nord'
colorscheme nord
]]

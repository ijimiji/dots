-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.templ = {
-- install_info = {
--   url = "~/.config/nvim/parser/tree-sitter-templ",
--   files = {"src/parser.c", "src/scanner.c"}, 
--   generate_requires_npm = false,
--   requires_generate_from_grammar = false,
-- },
-- }
-- parser_config.go = {
-- install_info = {
--   url = "~/.config/nvim/parser/tree-sitter-go",
--   files = {"src/parser.c"}, 
--   generate_requires_npm = false,
--   requires_generate_from_grammar = false,
-- },
-- }
--

local configs = require("nvim-treesitter.configs")
configs.setup({
  ensure_installed = { "go", "templ", "vimdoc", "bash", "zig" },
  sync_install = false,
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { "lua" },
  },
})

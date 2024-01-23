vim.g.mapleader      = " "
vim.g.maplocalleader = ","

local ok, _ = pcall(require, "impatient")

vim.cmd.colorscheme("nord")

vim.api.nvim_set_hl(0, "RedBG",       {bg   = vim.g.terminal_color_1, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "RedFG",       {bg   = vim.g.terminal_color_8, fg = vim.g.terminal_color_1, bold = true})
vim.api.nvim_set_hl(0, "GreenBG",     {bg   = vim.g.terminal_color_2, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "YellowBG",    {bg   = vim.g.terminal_color_3, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "BlueBG",      {bg   = vim.g.terminal_color_4, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "MagentaBG",   {bg   = vim.g.terminal_color_5, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "CyanBG",      {bg   = vim.g.terminal_color_6, fg = vim.g.terminal_color_0, bold = true})

vim.o.guifont        = "FantasqueSansM Nerd Font:h20:b"
vim.o.autochdir      = false
vim.o.cmdheight      = 1
vim.o.cursorline     = false
vim.o.number         = true
vim.o.relativenumber = true
vim.o.termguicolors  = true
vim.o.expandtab      = true
vim.o.undofile       = true
vim.o.hidden         = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.shiftwidth     = 4
vim.o.softtabstop    = 4
vim.o.tabstop        = 4
vim.o.smartindent    = true
vim.o.textwidth      = 80
vim.o.updatetime     = 300
vim.o.signcolumn     = "auto"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "80"
vim.o.wildignorecase = true
vim.o.signcolumn     = "yes"
vim.o.foldmethod     = "expr"
vim.o.foldexpr       = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax    = 10
vim.o.foldlevel      = 10000
vim.o.list           = true
vim.opt.listchars    = {
  space = "·",
  trail = "·",
  tab   = "  ",
}

do
  require("nvim-autopairs").setup {}
  require("nvim-surround").setup  {}
  require('nvim_comment').setup   {}
  require('go').setup             {}
end

do
  vim.keymap.set({"x", "n"}, "ga", "<Plug>(EasyAlign)", {remap = true})
end

do
  local fzf = require("fzf-lua")

  fzf.setup({
    winopts = {
      win_border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      height = 0.9, 
      width = 0.9,
      preview = {
        hidden = "hidden",
        wrap   = "nowrap",
      },
    },
  })

  vim.keymap.set("n", "<C-p>",      require("fzf-lua").files)
  vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
  vim.keymap.set("n", "<M-x>",      require("fzf-lua").commands)
  vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
  vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
  vim.keymap.set("n", "<M-s>",      require("fzf-lua").live_grep)
  vim.keymap.set("n", "<leader>b",  require("fzf-lua").buffers)
  vim.keymap.set("n", "<leader>q",  require("fzf-lua").quickfix)
  vim.keymap.set("n", "<C-x><C-f>", require("fzf-lua").files)
  vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
  vim.keymap.set("n", "<C-r>",      require("fzf-lua").resume)
  -- vim.keymap.set("n", "<C-]>",      require("fzf-lua").buffers)
  -- vim.keymap.set("n", "<C-[>",      require("fzf-lua").quickfix)

  vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
  vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations)

  fzf.register_ui_select()
end

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
  callback = function()
    require'vim.highlight'.on_yank{higroup="IncSearch", timeout=250}
  end
})

do
  local luasnip = require("luasnip")
  local cmp     = require('cmp')

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
      ["<CR>"]      = cmp.mapping.confirm({ select = false }),
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


do
  vim.keymap.set("n", "<leader>e",  vim.cmd.Explore)
  vim.keymap.set("v", ">",          ">gv")
  vim.keymap.set("v", "<",          "<gv")
  vim.keymap.set("n", "n",          "nzzzv")
  vim.keymap.set("n", "N",          "Nzzzv")
  vim.keymap.set("i", ",",          ",<C-g>u")
  vim.keymap.set("i", ".",          ".<C-g>u")
  vim.keymap.set("n", "L",          ";")
  vim.keymap.set("n", "H",          ",")
  vim.keymap.set("n", "Y",          "y$")
  vim.keymap.set("n", "J",          "mzJ`z")
  vim.keymap.set("n", "<leader>q",  vim.cmd.copen)
  vim.keymap.set("t", "<esc>",      "<C-\\><C-n>")
  vim.keymap.set("n", "<esc>",      vim.cmd.noh)
  vim.keymap.set("n", "<C-u>",      "<C-u>zz")
  vim.keymap.set("n", "<C-d>",      "<C-d>zz")
  vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
  vim.keymap.set("v", "K",          ":m '<-2<CR>gv=gv")
  vim.keymap.set("v", "J",          ":m '>+1<CR>gv=gv")
end


function status_line()
  local mode_map = {
    ['n']  = 'NORMAL',
    ['no'] = 'N·OPERATOR',
    ['v']  = 'VISUAL',
    ['V']  = 'V·LINE',
    ['']   = 'V·BLOCK',
    [''] = 'V·BLOCK',
    ['s']  = 'SELECT',
    ['S']  = 'S·LINE',
    [''] = 'S·BLOCK',
    ['i']  = 'INSERT',
    ['ic'] = 'INSERT',
    ['R']  = 'REPLACE',
    ['Rv'] = 'V·REPLACE',
    ['c']  = 'COMMAND',
    ['cv'] = 'VIM·EX',
    ['ce'] = 'EX',
    ['r']  = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!']  = 'SHELL',
    ['t']  = 'TERMINAL',
  }
  local mode = mode_map[vim.api.nvim_get_mode().mode] or '?'

  local statusline = ""

  local pos = " "
  do
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars =
    { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    pos = chars[index]
  end

  statusline = statusline .. "%#RedBG#"
  statusline = statusline .. " " .. mode .. " "

  statusline = statusline .. "%#YellowBG#"
  statusline = statusline .. " %f "

  statusline = statusline .. "%#default#"

  statusline = statusline .. "%="

  statusline = statusline .. "%#GreenBG#"
  statusline = statusline .. " %l:%c "

  statusline = statusline .. "%#RedFG#"
  statusline = statusline .. pos

  statusline = statusline .. "%#BlueBG#"
  statusline = statusline .. " %Y "

  return statusline
end


vim.opt.statusline = '%!v:lua.status_line()'

require('tabout').setup {}

local snippets = require("luasnip.loaders.from_vscode")
snippets.lazy_load({ exclude = { "tex" } })

do
local function copy_arcadia_link(rev)
    local _, file_path = vim.fn.expand("%:p"):match("(.+)(arcadia/.+)")
    if file_path == nil then
        print("not an arcadia repo")
        return
    end

    local ln = vim.fn.line(".")
    local link = string.format("https://a.yandex-team.ru/%s?rev=%s#%d", file_path, rev, ln)
    print(link)
    vim.cmd(string.format([[call setreg("+", "%s")]], link))
end

vim.keymap.set("n", "<leader>at", function()
  copy_arcadia_link("trunk")
end)

vim.keymap.set("n", "<leader>ab", function()
    local f = assert(io.popen('arc rev-parse HEAD', 'r'))
    local rev = f:read('*all'):gsub("%s*", "")
    f:close()
    copy_arcadia_link("rev")
end)
end

do
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.templ = {
    install_info = {
      url = "~/.config/nvim/parser/tree-sitter-templ",
      files = {"src/parser.c", "src/scanner.c"}, 
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
  }
  parser_config.go = {
    install_info = {
      url = "~/.config/nvim/parser/tree-sitter-go",
      files = {"src/parser.c"}, 
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
  }

  local configs = require("nvim-treesitter.configs")
  configs.setup({
    ensure_installed = { "go", "templ", "vimdoc", "bash" },
    sync_install = false,
    highlight = { enable = true },
    indent = { 
      enable = true,
      disable = { "lua" },
    },  
  })
end



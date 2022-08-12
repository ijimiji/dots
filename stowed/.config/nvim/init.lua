local lsp_servers = { 
    "clangd", 
    "rust_analyzer", 
    "pyright",
    "gopls",
    "texlab"
}

local cmp_backends = {
    "nvim_lsp", 
    "luasnip", 
    "buffer",
    "path",
    "cmdline"
}

local packages = {
    "RRethy/nvim-base16",
    "lervag/vimtex",
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",
    "nvim-lua/plenary.nvim",
    "TimUntersberger/neogit",
    "kosayoda/nvim-lightbulb",
    "L3MON4D3/LuaSnip",
    "nvim-lualine/lualine.nvim",
    "ryvnf/readline.vim",
    "junegunn/vim-easy-align",
    "rcarriga/nvim-notify",
    "windwp/nvim-autopairs",
    "terrortylor/nvim-comment",
    "kylechui/nvim-surround",
    "ijimiji/tabout.nvim",
    "RishabhRD/nvim-lsputils",
    "RishabhRD/popfix",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "ijimiji/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "rafamadriz/friendly-snippets",
    "nvim-telescope/telescope.nvim",
    "ijimiji/std.lua"
}

vim.g.maplocalleader = ","
vim.g.mapleader      = " "
vim.o.autochdir      = true
vim.o.cursorline     = true
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
vim.o.textwidth      = 80
vim.o.updatetime     = 300
vim.o.signcolumn     = "number"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "+1"
vim.o.wildmode       = "lastused:longest"
vim.o.wildignorecase = true

local icons = {
    warning       = "◍",
    problem       = "◍",
    info          = "◍",
    hint          = "◍",
    bulb          = "◍",
    Text          = "",
    Method        = "",
    Function      = "",
    Constructor   = "",
    Field         = "",
    Variable      = "",
    Class         = "ﴯ",
    Interface     = "",
    Module        = "",
    Property      = "ﰠ",
    Unit          = "",
    Value         = "",
    Enum          = "",
    Keyword       = "",
    Snippet       = "",
    Color         = "",
    File          = "",
    Reference     = "",
    Folder        = "",
    EnumMember    = "",
    Constant      = "",
    Struct        = "",
    Event         = "",
    Operator      = "",
    TypeParameter = ""
}

do 
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    end
    require("packer").startup(function()
        for _, package in ipairs(packages) do
            use{package}
        end
        if packer_bootstrap then
            require('packer').sync()

        end
    end)
end

require("impatient")

local std = require("std")
local auto = vim.api.nvim_create_autocmd 
local map = vim.keymap.set
local noremap = {noremap = true}
local fmt = string.format
local colors = {}

function shade_color(color, delta)
    local hex = string.sub(color, 2, 7)
    return fmt("#%06x", std.max(std.min(tonumber("0x" .. hex) + delta, 0xffffff), 0x000000))
end

function colorscheme(theme, bat)
    vim.cmd("colorscheme " .. theme)
    if bat then
        vim.cmd(fmt("let $BAT_THEME = '%s'", (bat and bar or "ansi")))
    end
    colors["black"]         = vim.g.terminal_color_0
    colors["red"]           = vim.g.terminal_color_1
    colors["green"]         = vim.g.terminal_color_2
    colors["yellow"]        = vim.g.terminal_color_3
    colors["blue"]          = vim.g.terminal_color_4
    colors["magenta"]       = vim.g.terminal_color_5
    colors["cyan"]          = vim.g.terminal_color_6
    colors["white"]         = vim.g.terminal_color_7
    colors["grey"]          = vim.g.terminal_color_8
    colors["light_red"]     = vim.g.terminal_color_9
    colors["light_green"]   = vim.g.terminal_color_10
    colors["light_yellow"]  = vim.g.terminal_color_11
    colors["light_blue"]    = vim.g.terminal_color_12
    colors["light_magenta"] = vim.g.terminal_color_13
    colors["light_cyan"]    = vim.g.terminal_color_14
    colors["light_white"]   = vim.g.terminal_color_15
end

colorscheme("base16-nord")




do 
    local ls = require("luasnip")
    function load_snippets(filetype) 
        local snippets = require("snippets."..filetype)

        if snippets.auto ~= nil then
            ls.add_snippets(filetype, snippets["auto"], { 
                type = "autosnippets", 
                key = "all_auto", 
            })
            ls.add_snippets(filetype, snippets["normal"])
        else 
            ls.add_snippets(filetype, snippets)
        end
    end

    ls.config.setup {
        history = true,
        enable_autosnippets = true,
    }
    load_snippets("tex")

end

require("luasnip.loaders.from_vscode").lazy_load({exclude = {"tex"}})

require('nvim-lightbulb').setup({autocmd = {enabled = true}})
require("nvim-autopairs").setup{}
require("nvim_comment").setup{}
require("nvim-surround").setup{}
require("mason").setup{}

require("mason-lspconfig").setup{
    ensure_installed = lsp_servers
}

do 
    vim.api.nvim_set_hl(0, "DiagnosticWarn", {fg = colors.yellow})
    signs = {Error = icons["problem"], Warn = icons["warning"], Hint = icons["hint"], Info = icons["hint"], Bulb = icons["bulb"]}
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    vim.fn.sign_define("LightBulbSign", {text = signs["Bulb"], texthl = "LspDiagnosticsDefaultWarning", linehl = "", numhl = ""})
end

do 
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
    local on_attach = function()
        map("n", "gD",        vim.lsp.buf.declaration, noremap)
        map("n", "gd",        vim.lsp.buf.definition, noremap)
        map("n", "<C-LeftMouse>",        vim.lsp.buf.definition, noremap)
        map("n", "K",         vim.lsp.buf.hover, noremap)
        map("n", "gi",        vim.lsp.buf.implementation, noremap)
        map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, noremap)
        map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, noremap)
        map("n", "<space>wl", "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", noremap)
        map("n", "<space>D",  vim.lsp.buf.type_definition, noremap)
        map("n", "<space>r",  vim.lsp.buf.rename, noremap)
        map("n", "<space>ca", vim.lsp.buf.code_action, noremap)
        map("n", "gr",        vim.lsp.buf.references, noremap)
        map("n", "<space>f",  vim.lsp.buf.formatting, noremap)
        map("n", "<c-j>", "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'single' }})<CR>", noremap)
        map("n", "<c-k>", "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'single' }})<CR>", noremap)
    end
    local lspconfig = require('lspconfig')
    for _,server in ipairs(lsp_servers) do
        lspconfig[server].setup{
            on_attach = on_attach,
        }
    end
end

do
    local luasnip = require("luasnip")
    local cmp = require'cmp'

    map("c", "<C-n>", cmp.select_next_item, noremap)
    map("c", "<C-p>", cmp.select_prev_item, noremap)

    map("c", "<Tab>", cmp.select_next_item, {})
    map("c", "<S-Tab>", cmp.select_prev_item, {})


    local sources = {}

    for _, source in ipairs(cmp_backends) do
        table.insert(sources, { name = source })
    end

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
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered({
                border = "single"
            }),
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
                return vim_item
            end
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

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        })
    }) 
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })
end


do
    local nord_theme = {
        inactive = {
            a = { bg = colors.grey, fg = colors.black, gui = "bold" },
            b = { bg = colors.grey, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.grey, fg = colors.black },
            z = { bg = colors.grey, fg = colors.black },
        },
        visual = {
            a = { bg = colors.blue, fg = colors.black, gui = "bold" },
            b = { bg = colors.yellow, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.blue, fg = colors.black },
            z = { bg = colors.yellow, fg = colors.black },
        },
        replace = {
            a = { bg = colors.magenta, fg = colors.black, gui = "bold" },
            b = { bg = colors.yellow, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.blue, fg = colors.black },
            z = { bg = colors.yellow, fg = colors.black },
        },
        normal = {
            a = { bg = colors.red,  fg = colors.black, gui = "bold" },
            b = { bg = colors.yellow, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.blue, fg = colors.black },
            z = { bg = colors.yellow, fg = colors.black },

        },
        insert = {
            a = { bg = colors.green, fg = colors.black, gui = "bold" },
            b = { bg = colors.yellow, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.blue, fg = colors.black },
            z = { bg = colors.yellow, fg = colors.black },
        },
        command = {
            a = { bg = colors.white,fg = colors.black, gui = "bold" },
            b = { bg = colors.yellow, fg = colors.black },
            c = { bg = colors.grey, fg = colors.black },
            x = { bg = colors.grey, fg = colors.red },
            y = { bg = colors.blue, fg = colors.black },
            z = { bg = colors.yellow, fg = colors.black },
        },
    }
    require('lualine').setup {
        options = {
            icons_enabled = icons,
            theme = nord_theme,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true,
            bg = colors.grey
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'filename'},
            lualine_c = {{"branch", "diff", "diagnostics", color = {fg = colors.black, bg = colors.red}}},
            lualine_y = {{"encoding", padding = 1}},
            lualine_z = {{"filesize", padding = 1}},
            lualine_x = {
                {
                    function()
                        local current_line = vim.fn.line "."
                        local total_lines = vim.fn.line "$"
                        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                        local line_ratio = current_line / total_lines
                        local index = math.ceil(line_ratio * #chars)
                        return chars[index]
                    end,
                    padding = { left = 0, right = 0 },
                }
            },
        },
    }

end


do 
    map({"x", "n"}, "ga", "<Plug>(EasyAlign)", {})
    map("v", ">", ">gv", noremap)
    map("v", "<", "<gv", noremap)
    map("n", "n", "nzzzv", noremap)
    map("n", "N", "Nzzzv", nnoremap)
    map("i", ",", ",<C-g>u", noremap)
    map("i", ".", ".<C-g>u", noremap)
    map("n", "L", "g$", noremap)
    map("n", "H", "^]", noremap)
    map("n", "Y", "y$", noremap)
    map("t", "<esc>", "<C-\\><C-n>", noremap)
    map("n", "<esc>", "<cmd>noh<cr>", {})
end

do
    auto("BufReadPost", {
        pattern = "*", 
        group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
        callback = function() 
            if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.cmd("normal! g`\"")
            end
        end
    })

    auto("TextYankPost", {
        pattern = "*", 
        group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
        callback = function() 
            require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
        end
    })
end

do
    local attach_to_buffer = function(output_bufnr, pattern, command)
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("jahor-autorun", {clear = true}),
            pattern = pattern,
            callback = function()
                local append_data = function(_, data)
                    if data then
                        vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                    end
                end

                vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {"output: "})
                vim.fn.jobstart(command, {
                    stdout_buffered = true,
                    on_stdout = append_data,
                    on_stderr = append_data,
                })
            end,
        })
    end

    vim.api.nvim_create_user_command("AutoRun", function()
        vim.cmd("vsplit")
        local prev_win = vim.fn.win_findbuf(vim.fn.bufnr("%"))[1]
        local bufnr = vim.api.nvim_create_buf(true, true)
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, bufnr)

        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        vim.api.nvim_set_current_win(prev_win)

        local pattern = vim.fn.input("Pattern: ")
        local command = vim.split(vim.fn.input("Command: "), " ")
        attach_to_buffer(tonumber(bufnr), pattern, command)
    end, {})
end


do
    map("n", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
    map("t", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
    vim.api.nvim_create_user_command("ToggleTerm", function()
        local height = 15
        local buffer_id = vim.fn.bufnr("term")
        local window_id = vim.fn.win_findbuf(buffer_id)[1]

        if window_id then
            return vim.api.nvim_win_hide(0)
        else
            vim.cmd("split")
            if (buffer_id == -1) then
                vim.cmd("terminal")
            else
                vim.cmd(("buffer " .. buffer_id))
            end

            vim.cmd(("resize " .. height))

            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.cursorline = false

            vim.cmd("startinsert!")
        end
    end, {})
end


do

    local function get_font_table()
        local font = std.strsplit(vim.o.guifont, ":")
        font[2] = tonumber(string.sub(font[2], 2, 3))

        return font
    end

    local function font_tbl_to_string(tbl)
        return std.strjoin(tbl, ":")
    end

    local function change_font_size(delta)
        local font = get_font_table() 
        font[2] = "h" .. std.min(std.max(font[2] + delta, 5), 60)
        vim.o.guifont = font_tbl_to_string(font)
    end

    local delta = 1

    map({"n", "i", "c", "v", "s"}, "<C-MouseDown>", function()
        change_font_size(delta)
    end, noremap)

    map({"n", "i", "c", "v", "s"}, "<C-MouseUp>", function()
        change_font_size(-delta)
    end, noremap)
end

do
    require('telescope').setup{
        defaults = {
            border = false,
        },
        pickers = {
            find_files = {
                theme = "dropdown",
            },
            commands = {
                theme = "dropdown",
            },
            buffers = {
                theme = "dropdown",
            },
            help_tags = {
                theme = "dropdown",
            },
        }
    }

    local delta = 0x050505

    vim.api.nvim_set_hl(0, "TelescopeNormal", {
        bg = shade_color(colors.black, delta),
        fg = colors.white
    })

    vim.api.nvim_set_hl(0, "TelescopeBorder", {
        bg = shade_color(colors.black, delta),
        fg = shade_color(colors.black, delta),
    })

    vim.api.nvim_set_hl(0, "TelescopePromptNormal", {
        bg = shade_color(colors.black, delta),
        fg = colors.blue
    })

    vim.api.nvim_set_hl(0, "TelescopeMatching", {
        fg = colors.yellow
    })

    vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
        bg = shade_color(colors.black, delta),
        fg = shade_color(colors.black, delta),
    })

    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {
        bg = shade_color(colors.black, delta),
        fg = colors.red
    })

    map("n", "<C-x><C-f>", require'telescope.builtin'.find_files, noremap)
    map("n", "<C-x><C-b>", require'telescope.builtin'.buffers,    noremap)
    map("n", "<C-x><C-h>", require'telescope.builtin'.help_tags,  noremap)
    map("n", "<M-x>",      require'telescope.builtin'.commands,   noremap)
end

do
    vim.api.nvim_create_user_command("Update", function()
        vim.cmd [[source %]]
        require('packer').sync()
    end, {})
end

if vim.fn.exists("g:neovide") ~= 0 then
    vim.o.guifont = "Iosevka Term:h18"
end

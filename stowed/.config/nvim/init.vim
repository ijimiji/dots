nnoremap n     nzzzv
nnoremap N     Nzzzv
inoremap ,     ,<C-g>u
inoremap .     .<C-g>u
nnoremap L     g$
nnoremap H     ^
nnoremap Y     y$
vnoremap >     >gv
vnoremap <     <gv
vnoremap s     :s/
tnoremap <esc> <C-\><C-n>
xmap     ga    <Plug>(EasyAlign)
nmap     ga    <Plug>(EasyAlign)

set omnifunc=syntaxcomplete#Complete
set autochdir
set cursorline
set number
set relativenumber
set termguicolors
set expandtab
set undofile
set hidden
set splitbelow
set splitright
set ignorecase
set smartcase
set shiftwidth=4
set softtabstop=4
set textwidth=80
set updatetime=300
set signcolumn=number
set background=dark
set mouse=a
set inccommand=nosplit
set clipboard=unnamedplus,unnamed
set colorcolumn=+1"
set wildmode=full"
let maplocalleader = ","
let mapleader      = " "

lua << EOF
local execute   = vim.api.nvim_command
local fn        = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt       = string.format
local auto      = vim.api.nvim_create_autocmd
function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

ensure("ryvnf",        "readline.vim")
ensure("RRethy",       "nvim-base16")
ensure("ijimiji",      "tabout.nvim")
ensure("junegunn",     "vim-easy-align")
ensure("tpope",        "vim-surround")
ensure("tpope",        "vim-commentary")
ensure("jiangmiao",    "auto-pairs")
ensure("nvim-lualine", "lualine.nvim")
vim.cmd("colorscheme base16-nord")

if vim.g.terminal_color_0 ~= nil then
    local black         = vim.g.terminal_color_0
    local red           = vim.g.terminal_color_1
    local green         = vim.g.terminal_color_2
    local yellow        = vim.g.terminal_color_3
    local blue          = vim.g.terminal_color_4
    local magenta       = vim.g.terminal_color_5
    local cyan          = vim.g.terminal_color_6
    local white         = vim.g.terminal_color_7
    local grey          = vim.g.terminal_color_8
    local light_red     = vim.g.terminal_color_9
    local light_green   = vim.g.terminal_color_10
    local light_yellow  = vim.g.terminal_color_11
    local light_blue    = vim.g.terminal_color_12
    local light_magenta = vim.g.terminal_color_13
    local light_cyan    = vim.g.terminal_color_14
    local light_white   = vim.g.terminal_color_15
    local currentmode = {
        ["n"]     = red,
        ["v"]     = green,
        ["V"]     = blue,
        ["<C-V>"] = cyan,
        ["i"]     = green,
        ["R"]     = magenta,
        ["Rv"]    = magenta,
        ["c"]     = white
    }
    require('lualine').setup {
        options = {
            icons_enabled = false,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = {{'mode', color =  function() return {bg = currentmode[vim.fn.mode()],  fg = black} end }},
            lualine_b = {{'filename', color = {fg = black, bg = yellow}}},
            lualine_c = {{'branch', 'diff', 'diagnostics', color = {fg = black, bg = red}}},
            lualine_y = {
                {
                    "encoding", 
                    padding = 1,
                    color = {bg = blue, fg = black},
                }
            },
            lualine_z = {
                {
                    "filesize", 
                    padding = 1,
                    color = {bg = yellow, fg = black},
                }
            },
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
                    color = {fg = red, bg = grey},
                    cond = nil
                }
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    }
end

auto("TextYankPost", {
    pattern = "*", 
    callback = function() 
    require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
end})
EOF

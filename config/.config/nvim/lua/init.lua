local _2afile_2a = ".config/nvim/fnl/init.fnl"
local unpack = (table.unpack or _G.unpack)
local fmt = string.format
local function nnoremap(from, to)
  return vim.cmd(fmt("nnoremap %s %s", from, to))
end
nnoremap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nnoremap("<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
nnoremap("<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
nnoremap("<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
nnoremap("<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nnoremap("<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
nnoremap("<c-k>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
nnoremap("<c-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
nnoremap("<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
local function map(f, tbl)
  local t = {}
  for _, v in ipairs(tbl) do
    table.insert(t, f(v))
  end
  return t
end
local function max(x, y, ...)
  if (type(x) == "table") then
    return max(unpack(x))
  else
    local greater
    if (x > y) then
      greater = x
    else
      greater = y
    end
    if (#{...} == 0) then
      return greater
    else
      return max(greater, ...)
    end
  end
end
local function min(x, y, ...)
  if (type(x) == "table") then
    return min(unpack(x))
  else
    local smaller
    if (x < y) then
      smaller = x
    else
      smaller = y
    end
    if (#{...} == 0) then
      return smaller
    else
      return min(smaller, ...)
    end
  end
end
local function split_string(str, sep)
  local t = {}
  for token in string.gmatch(str, (sep or "([^%s]+)")) do
    table.insert(t, token)
  end
  return t
end
local function change_font_size(delta)
  local tokens = split_string(vim.o.guifont, "[^:][^h]+")
  local font_height = min(50, max(5, (string.sub(tokens[#tokens], 2) + delta)))
  local font_name = tokens[1]
  vim.o.guifont = (font_name .. ":h" .. font_height)
  return nil
end
_G.decrease_font = function()
  return change_font_size(-2)
end
_G.increase_font = function()
  return change_font_size(2)
end
_G.ToggleTerm = function(height)
  local buffer_id = vim.fn.bufnr("term")
  local window_id = vim.fn.win_findbuf(buffer_id)[1]
  if window_id then
    return vim.cmd("hide")
  else
    vim.cmd("split")
    if (buffer_id == -1) then
      vim.cmd("terminal")
    else
      vim.cmd(("buffer " .. buffer_id))
    end
    vim.cmd(("resize " .. height))
    return vim.cmd("startinsert!\n          set noshowmode\n          set nonumber\n          set norelativenumber")
  end
end
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require("nvim-lsp-installer.servers")
local function _9_(server)
  local function _10_(client, buffer)
    return vim.cmd("autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()")
  end
  return server:setup({capabilities = (require("cmp_nvim_lsp")).update_capabilities(vim.lsp.protocol.make_client_capabilities()), flags = {debounce_text_changes = 150}, on_attach = _10_}, vim.cmd("do User LspAttachBuffers"))
end
lsp_installer.on_server_ready(_9_)
local servers = {"pyright", "tsserver", "clangd", "jdtls"}
for _, server_name in ipairs(servers) do
  local _let_11_ = {lsp_installer_servers.get_server(server_name)}
  local ok = _let_11_[1]
  local server = _let_11_[2]
  if (ok and not server:is_installed()) then
    server:install()
  else
  end
end
local signs = {Error = "!", Warning = "*", Hint = "$", Info = "#"}
for type, icon in pairs(signs) do
  local hl = ("LspDiagnosticsSign" .. type)
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
vim.fn.sign_define("LightBulbSign", {text = "@", texthl = "DiagnosticWarn", linehl = "", numhl = ""})
local cmp = require("cmp")
local lspkind = require("lspkind")
local function _13_(args)
  return vim.fn["vsnip#anonymous"](args.body)
end
cmp.setup({snippet = {expand = _13_}, mapping = {["<C-Space>"] = cmp.mapping(cmp.mapping.complete()({"i", "c"})), ["<C-y>"] = cmp.config.disable, ["<C-e>"] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}), ["<CR>"] = cmp.mapping.confirm({select = false})}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "path"}, {name = "vsnip"}, {name = "conjure"}, {name = "buffer"}}), formatting = {format = lspkind.cmp_format({with_text = false, maxwidth = 50, symbol_map = {Text = "tx", Method = "m", Function = "f", Constructor = "c", Field = "f", Variable = "v", Class = "c", Interface = "i", Module = "{", Property = "p", Unit = "u", Value = "v", Enum = "en", Keyword = "kw", Snippet = "sn", Color = "cl", File = "fl", Reference = "rf", Folder = "dr", EnumMember = "e", Constant = "c", Struct = "st", Event = "ec", Operator = "op", TypeParameter = "t"}})}})
do end (require("nvim_comment")).setup()
return (require("nvim-autopairs")).setup({disable_filetype = {"fennel", "clojure"}})
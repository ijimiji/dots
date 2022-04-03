local lspsaga = require 'lspsaga'
lspsaga.setup {}

return function()
    vim.cmd [[
    xnoremap gx :<c-u>Lspsaga range_code_action<cr>
    nnoremap gr <cmd>Lspsaga rename<cr>
    nnoremap gx <cmd>Lspsaga code_action<cr>
    nnoremap K  <cmd>Lspsaga hover_doc<cr>
    nnoremap go <cmd>Lspsaga show_line_diagnostics<cr>
    nnoremap gj <cmd>Lspsaga diagnostic_jump_next<cr>
    nnoremap gk <cmd>Lspsaga diagnostic_jump_prev<cr>
    nnoremap <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>
    nnoremap <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>
    ]]
end


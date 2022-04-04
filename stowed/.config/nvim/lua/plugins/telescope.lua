return function()
    require('telescope').setup{}
    nnoremap("<C-x><C-f>", [[:lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy())<cr>]])
    nnoremap("<M-x>", [[:lua require'telescope.builtin'.commands(require('telescope.themes').get_ivy())<cr>]])
end

unlet b:current_syntax

syn include @Vim $VIMRUNTIME/syntax/vim.vim
syn region embedvim matchgroup=luaEmbedError start='(vim\.cmd "' end='")' keepend contains=@Vim
" syn region embedvim matchgroup=luaEmbedError start="vim\.cmd('" end="')" keepend contains=@Vim

let b:current_syntax = 'fennel'

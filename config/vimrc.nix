syntax on
filetype on
set tabstop=2
set shiftwidth=2
set expandtab
set magic
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
set viminfo='20,<1000

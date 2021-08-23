""" General settings
set number relativenumber
set nu rnu
set cursorline

" Make vim prefer a buffer already open
set switchbuf=useopen,usetab,newtab
set showcmd
set clipboard+=unnamedplus
set belloff=all

" Remove SnipMate deprecate msg
let g:snipMate = { 'snippet_version' : 0 }


""" Colorscheme stuff
syntax enable
set t_Co=256
set t_ut=
colorscheme codedark


""" Functions
" Toggle light/dark mode
function SwapBG()
    if &bg == 'light'
        set bg=dark
    else
        set bg=light
    endif
endfunction


""" Key mappings
" Buffer traversal stuff
"map <F2> :call SwapBG()<CR>
nnoremap <F3> :bprev<CR>
nnoremap <F4> :bnext<CR>
nnoremap gb :ls<CR>:b  
nnoremap <leader>tt :split term://bash<CR>10<C-W>-<C-W>r

" Make Y behave like D and C
nnoremap Y y$

" Make gf open files in new tabs
nnoremap <leader>gf <C-W>gf

""" General settings
set number relativenumber
set nu rnu

" Make vim prefer a buffer already open
set switchbuf=useopen,usetab,newtab
set showcmd
set clipboard+=unnamedplus
set belloff=all

" Remove SnipMate deprecate msg
let g:snipMate = { 'snippet_version' : 0 }


""" Colorscheme stuff
"colorscheme peachpuff
"set bg=light
"syntax enable
"colorscheme peaksea
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
map <F2> :call SwapBG()<CR>
map <F3> :bprev<CR>
map <F4> :bnext<CR>
nnoremap gb :ls<CR>:b  


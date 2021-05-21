set number relativenumber
set nu rnu

colorscheme peachpuff
set bg=light
syntax enable
colorscheme peaksea

set belloff=all

" Toggle light/dark mode
function SwapBG()
    if &bg == 'light'
        set bg=dark
    else
        set bg=light
    endif
endfunction
map <F2> :call SwapBG()<CR>

" Auto light/dark mode
let s:hour = str2nr(system("date +'%H'"))
let s:lower = 8
let s:upper = 20
if s:hour <= s:lower || s:hour >= s:upper
    set bg=dark
else
    set bg=light
endif

" Remove SnipMate deprecate msg
let g:snipMate = { 'snippet_version' : 0 }

" Buffer traversal stuff
map <F3> :bprev<CR>
map <F4> :bnext<CR>
nnoremap gb :ls<CR>:b  

" Make vim prefer a buffer already open
set switchbuf=useopen,usetab,newtab

set showcmd

set clipboard+=unnamedplus

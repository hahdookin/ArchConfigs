""" General settings
set number relativenumber
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
" Only for transparent background
" hi Normal guibg=NONE ctermbg=NONE 
" hi LineNr guibg=NONE ctermbg=NONE 
" hi BufTabLineFill guibg=NONE ctermbg=NONE
" hi BufTabLineHidden guibg=NONE ctermbg=NONE
" hi CursorLineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE


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
"map <F2> :call SwapBG()<CR>
nnoremap <silent><leader>gt :bnext<CR>
nnoremap <silent><leader>gT :bprev<CR>
nnoremap gb :ls<CR>:b  

nnoremap <leader>tt :split term://bash<CR>10<C-W>-<C-W>r
nnoremap <leader>tr 10<C-W>-
let g:NERDTreeWinPos="left"
nnoremap <leader>tf :NERDTree<CR>

nnoremap <silent><leader>no :noh<CR>

" Make Y behave like D and C
nnoremap Y y$

" Make gf open files in new tabs
nnoremap <leader>gf <C-W>gf

nnoremap gt :bnext<CR>
nnoremap gT :bprev<CR>


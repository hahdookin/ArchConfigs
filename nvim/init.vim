"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Christopher Pane (hahdookin) .vimrc
"
" ChrisPaneCS@gmail.com
" https://www.chrispane.dev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set plugin directories
set packpath-=~/.vim
set packpath+=~/.vim/common
if has("nvim")
    set packpath+=~/.vim/nvim
else
    set packpath+=~/.vim/vim
endif

let mapleader = ","

let g:colorscheme = "spaceduck"

filetype plugin on
filetype indent on
syntax enable

if has('termguicolors')
    set termguicolors
endif

set history=500

" Set to auto read when a file is changed from the outside
set autoread
" au FocusGained,BufEnter * checktime

" 7 lines to the cursor
set so=7

let $LANG='en'
set langmenu=en
set encoding=utf8
set ffs=unix,dos,mac
set clipboard+=unnamedplus

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set hidden
set switchbuf=useopen
set stal=2

" set splitbelow
set splitright

set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignorecase
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set wildmode=full
set wildoptions=pum

set number relativenumber
set cursorline
set equalalways
set ruler

set foldcolumn=1

set cmdheight=1
set showcmd

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

set lazyredraw

set magic

" Matching delims
set showmatch
set mat=2

" Disable error notifs
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set belloff=all

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Indent
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Always show the status line
set laststatus=2

" Change cursor shape depending on insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Get termguicolors to work on st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"colorscheme spaceduck
exec "colorscheme " . g:colorscheme
" set bg=light
set bg=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

nnoremap <silent><leader>no :nohlsearch<CR>

" Make Y behave like D and C
nnoremap Y y$

" Swap buffers like swapping tabs
nnoremap gt :bnext<CR>
nnoremap gT :bprev<CR>

" Poor man's fuzzy finding
" This may break things: BEWARE
" set path+=**
" nnoremap <C-p> :find ./

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Spell checking
map <leader>ss :setlocal spell!<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimgrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! BuffersList()
    return range(1, bufnr('$'))
            \ ->filter('buflisted(v:val)')
            \ ->map('bufname(v:val)')
endfun
command! -nargs=* FindSymbol execute "vim" . " '<args>' " .  join(BuffersList())
" (f)ind (a)ll
nnoremap <leader>fa :execute "FindSymbol " . expand("<cword>")<CR>
" (f)ind (s)ymbol
nnoremap <leader>fs :FindSymbol

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
command! Bclose call <SID>BufcloseCloseIt()
nnoremap <leader>bd :Bclose<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.vim/init.vim<CR>
map <leader>m :source %<CR>
autocmd! BufWritePost ~/.vim/init.vim source ~/.vim/init.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Persistent udno
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quickfix stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cc :call ToggleQuickFix()<CR>
map <leader>ll :call ToggleLocationList()<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
        lclose
    endif
endfunction
function! ToggleLocationList()
    try
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            lopen
        else
            cclose
            lclose
        endif
    catch /E776/
        return
    endtry
endfunction

" Make sure that enter is never overriden in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Window navigation in terminal
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Escape in terminal mode
tnoremap <leader><Esc> <c-\><c-n>
" Toggle a terminal window at the bottom of the screen
" let g:toggled = #{init: 0, bufnr: 0, winnr: 0, open: 0}
" function ToggleTerm()
"     if !g:toggled.init
"         " Start a terminal buffer and remember its buffer number
"         if has("nvim")
"             bot split term://bash
"         else
"             bot terminal ++kill=hup
"         endif
"         let g:toggled.bufnr = uniq(map(filter(getwininfo(), 'v:val.terminal'), 'v:val.bufnr'))[0]
"         let g:toggled.init = 1
"     endif
"     if g:toggled.open
"         call win_execute(g:toggled.winnr, 'close')
"         let g:toggled.open = 0
"     else
"         exec "bot sbuffer " . g:toggled.bufnr
"         exec "resize " . float2nr(&lines * g:terminal_proportion)
"         setlocal winfixheight
"         setlocal nonumber norelativenumber
"         let g:toggled.winnr = win_getid()
"         let g:toggled.open = 1
"     endif
" endfunction

" " Toggle term maps
" nnoremap <silent> <leader>tt :call ToggleTerm()<CR>
" tnoremap <silent> <leader>tt <C-\><C-n>:call ToggleTerm()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_starting_directory = getcwd()
let g:netrw_last_directory = g:vim_starting_directory
let g:netrw_proportion = 0.18    " Amount of screen occupied by netrw :Lexplore

" netrw settings
let g:netrw_banner = 0 " Hide banner
let g:netrw_altv = 1 "
let g:netrw_altfile = 1
let g:netrw_winsize = -1 * floor(&columns * g:netrw_proportion) " Abs value = number of columns explorer takes up
let g:netrw_keepdir = 0
let g:netrw_browse_split = 4 " Split into previous window
let g:netrw_localcpdircmd = 'cp -r' " Recursively copy dir
augroup Netrw
    autocmd!
    autocmd FileType netrw call s:NetrwMapping()
augroup END

nnoremap gx :exec '!"$BROWSER" ' . shellescape("<cWORD>")<CR>

" Netrw mappings
function! s:NetrwMapping()
    if hasmapto('<Plug>NetrwRefresh')
        unmap <buffer> <C-l>
    endif
    " Ranger-like navigation
    nmap <buffer> h -^
    nmap <buffer> l <CR>

    nmap <buffer> . gh
    nmap <buffer> P <C-w>z

    nmap <buffer> <C-r> :e .<CR>

    nmap <buffer> <C-g> :Bclose<CR>:exec "e " . g:vim_starting_directory<CR>
endfunction

function s:CleanUselessBuffers()                                                   
    for buf in getbufinfo()                                                                                               
        if buf.name == "" && buf.changed == 0 && buf.loaded == 1                   
            :execute ':bdelete ' . buf.bufnr                                       
        endif                                                                      
    endfor                                                                         
endfunction                                                                 
                                                                                   
function s:ToggleLex()                                                             
    call s:CleanUselessBuffers()                                                   

    " let g:netrw_last_directory = getcwd()
                                                                                   
    " we iterate through the buffers again because some netrw buffers are          
    " skipped after we browsed to a different location and hence the name          
    " of the window changed (no longer '')                                         
    let flag = 0                                                                   
    for buf in getbufinfo()                                                        
        if (get(buf.variables, "current_syntax", "") == "netrwlist") && buf.changed == 0 && buf.loaded == 1
            :execute  ':bwipeout ' . buf.bufnr                                      
            let flag = 1                                                           
        endif                                                                      
    endfor                                                                         
                                                                                   
    if !flag                                                                    
        let g:netrw_winsize = -1 * floor(&columns * g:netrw_proportion)
        :Lexplore                                                               
        " exec "e " . g:netrw_last_directory
    endif                                                                       
endfunction
nnoremap <silent> <leader>tf :call <SID>ToggleLex()<CR>

hi! link netrwMarkFile Todo

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
au FileType gitcommit call setpos('.', [0, 1, 1, 0])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => miniterm.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:terminal_proportion = 0.28 " Amount of screen occupied by toggled terminal

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': g:colorscheme,
      \ 'active': {
      \   'left': [ ['mode'], ['filename', 'modified'], ['fugitive', 'readonly' ] ],
      \   'right': [ [ 'lineinfo'] , ['percent'], ['filetype', 'paste'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}',
      \   'paste': '%{&lines}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF buffers
nnoremap <leader>ff :Buffers<CR>
nnoremap <leader>fl :Lines<CR>

" FZF Files depending on whether or not in a git repo
function FuzzyFiles()
    GFiles
    " Error 128 occurs when not in Git repo path
    if v:shell_error == 128
        Files
    endif
endfunction
nnoremap <leader>fg :call FuzzyFiles()<CR>

" FZF in cur (d)ir
nnoremap <leader>fd :FZF<CR>
" FZF (i)n
nnoremap <leader>fi :FZF 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parenthesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 0
noremap <leader>rr :RainbowToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=300
" Tab will complete current best match if the PUM is visible, else it will
" just enter a \t
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
inoremap <silent><expr> <s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use  and  to navigate diagnostics
" Use  to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example:  for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add  command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add  command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add  command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see  for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startscreen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:start_screen_mru_count = 7 " Number of MRU files to show on start screen
" Path patterns to ignore when showing MRU on start screen
let g:start_screen_mru_ignore = [
    \ "^/usr/share/",
    \ "vimwiki"
    \]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Date stuff
let g:date_format = "%a %b %d %l:%M%p %Y %Z"
fun! InsertDate()
    return systemlist('date --date="' . input("Date: ") . '" +"' . g:date_format . '"')[0]
endfun
noremap <leader>ad  :exec "normal! a<" . InsertDate() . ">"<CR>

augroup VimwikiDates
    au!
    au BufReadPost,BufWritePost *.wiki call DateHighlighting()
augroup END

let g:date_positions = []

fun! DateHighlighting()
    let g:date_positions = []
    let save_view = winsaveview()
    let save_pos = getpos('.')
    let bn = bufnr()
    normal gg0
    hi DatePAST ctermfg=DarkGrey
    hi DateLTDAY ctermfg=DarkRed
    hi DateLT2DAY ctermfg=Red
    hi DateLTWEEK ctermfg=Yellow
    hi DateLTMONTH ctermfg=Green
    hi DateGTMONTH ctermfg=Blue
    if empty(prop_type_get('DateLTDAY', {'bufnr': bn}))
        call prop_type_add('DatePAST', { 'bufnr': bn, 'highlight': 'DatePAST', 'combine': 0 }) 
        call prop_type_add('DateLTDAY', { 'bufnr': bn, 'highlight': 'DateLTDAY', 'combine': 0 }) 
        call prop_type_add('DateLT2DAY', { 'bufnr': bn, 'highlight': 'DateLT2DAY', 'combine': 0 }) 
        call prop_type_add('DateLTWEEK', { 'bufnr': bn, 'highlight': 'DateLTWEEK', 'combine': 0 }) 
        call prop_type_add('DateLTMONTH', { 'bufnr': bn, 'highlight': 'DateLTMONTH', 'combine': 0 }) 
        call prop_type_add('DateGTMONTH', { 'bufnr': bn, 'highlight': 'DateGTMONTH', 'combine': 0 }) 
    endif
    while search('<.\{-}>', 'W') != 0
        let [_, lnum, col, _] = getpos('.')
        normal f>
        let endpos = col('.')
        let date = getline('.')[col : endpos - 2]
        let now = localtime()
        let then = strptime(g:date_format, date)
        if !then
            " call prop_add(lnum, col, {'bufnr': bn, 'length': endpos - col + 1, 'type': 'DateGTMONTH' })
            continue
        endif


        let diff = then - now

        let bn = bufnr()
        call add(g:date_positions, {'lnum': lnum, 'col': col, 'diff': diff, 'bufnr': bn, 'text': getbufline(bn, lnum)[0]})

        let one_day = 86400
        let two_day = one_day * 2
        let one_week = one_day * 7
        let one_month = one_day * 31
        let one_year = one_day * 365

        let type = ""
        if diff < 0
            let type = 'DatePAST'
        elseif diff < one_day
            let type = 'DateLTDAY'
        elseif diff < two_day
            let type = 'DateLT2DAY'
        elseif diff < one_week
            let type = 'DateLTWEEK'
        elseif diff < one_month
            let type = 'DateLTMONTH'
        else
            let type = 'DateGTMONTH'
        endif

        call prop_add(lnum, col, {'bufnr': bn, 'length': endpos - col + 1, 'type': type })
    endwhile
    call setpos('.', save_pos)
    call winrestview(save_view)
    " Sort positions [ [row, col, diff], ... ] by the difference a.k.a. Time
    " between now and the date.
    eval g:date_positions->sort({i1,i2 -> i1['diff'] - i2['diff']})
    call setqflist(g:date_positions, 'r')
endfun

let g:vimwiki_conceal_pre = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => minifuzzy.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Builds a Unix find command that ignores directories present in the
" "ignore_directories" list
let g:ignore_directories = [ 'node_modules', '.git' ]
fun! BuildFindCommand()
    let cmd_exprs = g:ignore_directories
                    \ ->mapnew('"-type d -name " . v:val . " -prune"')
    call add(cmd_exprs, '-type f -print')
    return 'find . ' . cmd_exprs->join(' -o ')
endfun

nnoremap <space> :MinifuzzyBuffers<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_bold = 0
let g:gruvbox_italic = 0
let g:gruvbox_contrast_dark = "medium"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! MyFuzFunc(A, L, P)
    let l:results = split(system("find . -type f -not -path '*/\\.git/*'"), "\n")
    return matchfuzzy(l:results, a:A)
endfun

set wcm=<C-Z>
cnoremap <C-TAB> <C-Z><C-P>
command! -nargs=1 -complete=customlist,MyFuzFunc Find edit <args>
nnoremap <C-p> :Find ./<C-Z><C-P>

map <leader>pd <Cmd>call popup_clear()<CR>


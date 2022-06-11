" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Specify the behavior when switching between buffers 
set switchbuf=useopen
set stal=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignorecase
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set number relativenumber
set cursorline
set noequalalways

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1
set showcmd

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set belloff=all

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable 
set t_Co=256
set t_ut=
if has('termguicolors')
    set termguicolors
endif
colorscheme codedark

" Gruvbox settings
if has("nvim")
    let g:gruvbox_bold = 0
    let g:gruvbox_italic = 0
    let g:gruvbox_contrast_dark = "medium"
endif
"colorscheme gruvbox

set clipboard+=unnamedplus

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" (g)oto (b)uffer
nnoremap gb :ls<CR>:b  

" Toggle a terminal window at the bottom of the screen
let g:toggled = #{init: 0, bufnr: 0, winnr: 0, open: 0}
function ToggleTerm()
    if !g:toggled.init
        split term://bash
        let g:toggled.bufnr = uniq(map(filter(getwininfo(), 'v:val.terminal'), 'v:val.bufnr'))[0]
        let g:toggled.init = 1
    endif
    if g:toggled.open
        call win_execute(g:toggled.winnr, 'close')
        let g:toggled.open = 0
    else
        exec "sbuffer " . g:toggled.bufnr
        resize -8
        exec "normal \<c-w>r"
        let g:toggled.winnr = win_getid()
        let g:toggled.open = 1
    endif
endfunction

nnoremap <silent> <leader>tt :call ToggleTerm()<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:call ToggleTerm()<CR>
nnoremap <leader>te :e term://bash<CR>

let g:NERDTreeWinPos="left"
nnoremap <leader>tf :NERDTree<CR>

nnoremap <silent><leader>no :nohlsearch<CR>

" Make Y behave like D and C
nnoremap Y y$

" Swap buffers like swapping tabs
nnoremap gt :bnext<CR>
nnoremap gT :bprev<CR>

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

" So much better but may affect a lot of stuff
" map '' ``

" vimgrep 
command! -nargs=* FindSymbol execute "vim" . " '<args>' " .  join(BuffersList())
" (f)ind (a)ll
nnoremap <leader>fa :execute "FindSymbol " . expand("<cword>")<CR>
" (f)ind (s)ymbol
nnoremap <leader>fs :FindSymbol 

" Show buffer numbers for buftabline
let g:buftabline_numbers=1

function! BuffersList()
    let all = range(1, bufnr('$'))
    let res = []
    for buf in all
        if buflisted(buf)
            call add(res, bufname(buf))
        endif
    endfor
    return res
endfunction

command! Find :exec "vim " . expand("<cword>") . " ##"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.config/nvim/init.vim<cr>
autocmd! bufwritepost ~/.vim_runtime/my_configs.vim source ~/.vim_runtime/my_configs.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Quickfix stuff
map <leader>co :botright cope<cr>
map <leader>cl :cclose<CR>
map <leader>cc :call ToggleQuickFix()<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" Make sure that enter is never overriden in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Languages that should use 2 space tabs
"autocmd Filetype *.css,*.vue,*.html setlocal tabstop=4

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif

""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
let vim_markdown_folding_disabled = 1

" Remove SnipMate deprecate msg
let g:snipMate = { 'snippet_version' : 0 }

function StreamerMode()
    " 13 pluses
    set norelativenumber
    set showtabline=0
    set scrolloff=0
    set nocursorline

    " Disable completion menu
    set completeopt=
    call compe#setup({'enabled':v:false})
endfunction

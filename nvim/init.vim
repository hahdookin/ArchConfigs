"NeoBundle Scripts-----------------------------
if has('vim_starting')
  " Required:
  set runtimepath+=/home/chris/.config/nvim/bundle/neobundle.vim/
endif

set runtimepath+=/home/chris/.config/bundle/

" Required:
call neobundle#begin(expand('/home/chris/.config/nvim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
NeoBundle 'tomasiser/vim-code-dark'
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" Treesitter stuff
NeoBundle 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
NeoBundle 'neovim/nvim-lspconfig'
NeoBundle 'hrsh7th/nvim-compe'


" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry


" ----------
"  Compe settings
" ----------
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


" ----------
"  LSP Setups
" ----------

" Bash
lua require'lspconfig'.bashls.setup{}
"let g:ale_linters = {
"    \ 'sh': ['language_server'],
"    \ }

" Clangd
lua require'lspconfig'.clangd.setup{}

" Python
lua require'lspconfig'.pyright.setup{}

" Rust
lua require'lspconfig'.rust_analyzer.setup{}


" Disable inline error/warning messages
lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

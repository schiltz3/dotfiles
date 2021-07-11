"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

"let g:coc_node_path = '/path/to/node'

set nocompatible
let mapleader=" "

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'

" GUI
Plug 'itchyny/lightline.vim'
Plug 'oldwomanjosiah/lightline-gruvbox.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rust
Plug 'rust-lang/rust.vim'

call plug#end()

autocmd vimenter * ++nested colorscheme gruvbox

" Main
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nu
set rnu
set signcolumn=yes " For empty gitgutter
set scrolloff=3
set cursorline
set colorcolumn=81
set list
set listchars=tab:·\ ,trail:•
set lazyredraw

" Neccesary for rust plugin
syntax enable
filetype plugin indent on

" Center Search Results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

set wildmenu
set wildmode=list:longest

" Splits Remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" Clear Arrow Keys
nnoremap <Up> <NoP>
nnoremap <Down> <NoP>
nnoremap <Left> <NoP>
nnoremap <Right> <NoP>

" Change split behavior to match tmux
set splitright
set splitbelow


" Undo over time
set undodir=~/.config/nvim/.nvimdid
set undofile

"Buffers
nnoremap <Leader><Leader> <C-^> " Map space-spcae to go to most recent buffer
set hidden " Allow switching through unwritten buffers

set showtabline=2


" Lightline Options
let g:lightline#bufferline#unicode_symbols=1
let g:lightline_gruvbox_color='both'
set showtabline=2
if !has('gui_running')
set t_Co=256
endif

let g:lightline = {
		\   'colorscheme': 'gruvbox',
		\   'active': {
		\     'left': [ [ 'mode', 'paste' ],
		\				[ 'cocstatus' ],
		\               [ 'readonly', 'filename', 'modified' ] ],
		\     'right':[ [ 'gitstatus' ],
		\				[ 'percent' ],
		\				[ 'filetype', 'encoding', 'lineinfo' ] ]
		\   },
		\   'tabline': {
		\     'left': [ [ 'buffers' ] ],
		\     'right': [ [ 'tabs' ] ]
		\   },
		\   'component_function': {
		\     'filename': 'LightlineFilename',
		\     'cocstatus': 'coc#status',
		\     'gitstatus': 'LightlineGitStatus',
		\   },
		\   'component_expand': {
		\     'buffers': 'lightline#bufferline#buffers'
		\   },
		\   'component_type': {
		\     'buffers': 'tabsel'
		\   },
		\ }

function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction
function! LightlineGitStatus() abort
	let status = get(g:, 'coc_git_status', '')
	return winwidth(0) > 100 ? status : ''
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" Completion
"
" Coc Options
" Diag
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>rn <Plug>(coc-rename)
" GoTo
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gd <Plug>(coc-definition)
" Coc Setup
" Better display for coc messages
 set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
 set updatetime=100
" Some servers have issues with backup files, see #649.
 set nobackup
 set nowritebackup

 " Always show the signcolumn, otherwise it would shift the text each time
 " diagnostics appear/become resolved.
 if has("patch-8.1.1564")
	 "   " Recently vim can merge signcolumn and number column into one
	 set signcolumn=number
 else
	 set signcolumn=yes
 endif

" Coc
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Show type annotation
nnoremap <Leader>t :call CocAction('doHover')<Cr>
nnoremap <Leader>T :call CocAction('doHover')<Cr>

set noshowmode

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
 inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

 function! s:check_back_space() abort
   let col = col('.') - 1
     return !col || getline('.')[col - 1]  =~# '\s'
 endfunction
 " Use <c-space> to trigger completion.
 if has('nvim')
   inoremap <silent><expr> <c-space> coc#refresh()
 else
  inoremap <silent><expr> <c-@> coc#refresh()
 endif

 " Formatting selected code.
 xmap <leader>f  <Plug>(coc-format-selected)
 nmap <leader>f  <Plug>(coc-format-selected)



" Add `:Format` command to format current buffer.
 command! -nargs=0 Format :call CocAction('format')

" Recognise .csx file extention as C#
autocmd BufNewFile,BufRead *.csx set syntax=csh





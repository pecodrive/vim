runtime! debian.vim

set visualbell t_vb=
set noerrorbells
set t_Co=256
set showcmd
set number
set list
set listchars=tab:>-,trail:_,eol:¬

set hlsearch
set wrapscan
set ignorecase
set smartcase
set incsearch

set hidden
set noswapfile

set softtabstop=4
set expandtab
set tabstop=4
set shiftwidth=4

set backspace=     "backspace無効

set laststatus=2
set statusline=[%F]%m%=[line=%l][col=%c]%P
set cursorline
set relativenumber
set ruler
set rulerformat=%15(%c%V\ %p%%%)

let loaded_matchparen = 1

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=/usr/share/vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('/usr/share/vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'sudo.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\     'windows' : 'tools\\update-dll-mingw',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make -f make_mac.mak',
	\     'linux' : 'make',
	\     'unix' : 'gmake',
	\    }, 
	\ }
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'szw/vim-tags'
call neobundle#end()
NeoBundleCheck

filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers =['jshint']
let g:syntastic_php_checkers =['php']
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['javascript','php'],
  \ 'passive_filetypes': ['html']
  \}
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" neocomplete

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" vim-tags
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"

" color 
colorscheme hybrid 
syntax on

" neosnipepet
let g:neosnippet#snippets_directory='/usr/share/vim/bundle/neosnippet-snippets/snippets/'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

inoremap jj <ESC>

map <F2> <C-w>w
map <F3> <C-w>c

noremap <Space>w :w<Cr>
noremap <Space>mw :w 
noremap <Space>wa :wa<Cr>
noremap <Space>mk :mksession! 
noremap <Space>! :! 
noremap <Space>a :qa<Cr>
noremap <Space>q :q<Cr>
noremap <Space>1 :q!<Cr>
noremap <Space>bd :bd!<Cr>
noremap <Space>l :ls<Cr>
noremap <Space>e :e 
noremap <Space>b :b 
noremap <Space>p :pwd<Cr>
noremap <Space>cd :cd 
noremap <Space>cl :lcd %:h<Cr>

noremap <F9> :bprevious<CR>
noremap <F10> :bnext<CR>

noremap <Right> <nop>
noremap <Left> <nop>
noremap <Up> <nop>
noremap <Down> <nop>
inoremap <Right> <nop>
inoremap <Left> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

noremap <ESC>e ge
noremap <ESC>w b

noremap <ESC>f F

noremap <F6> :split<CR>
noremap <F5> :vsplit<CR>


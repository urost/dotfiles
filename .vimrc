"{{{ Settings
" General
set nocompatible    " Disable vi compatibility
"for custom .vim folder, also place custom .vimrc in the same folder
"start vim with vim -u <custom vimrc>
" let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)
" let s:portable = expand('<sfile>:p:h')
" let &runtimepath = printf('%s,%s,%s/after', s:portable, &runtimepath, s:portable)
set modeline        " Enable modeline
set showmatch       " Show matching parentheses
set nocursorline    " Do not highlight cursor line
set nocursorcolumn  " Do not highlight current cursor column
set ruler           " Show cursor position
set laststatus=2    " Show status line
set noerrorbells    " No beeps
set history=1000    " Maximum history
set wildmenu        " Tab completion
set wildignore+=*/.git/*,*/.bzr/*,*~,*/build/*
set hidden          " Allow buffers to be hidden
set scrolloff=2     " At least two lines and ...
set sidescrolloff=2 " two columns context
set mouse=a         " Mouse support
set backspace=2     " to fix backspace issues
set tabpagemax=15 " increase number of tabs to 15
set tags=.tags      " Tags file
set ttyfast
set ttimeoutlen=0   " Timeout for keycodes, esp. <Esc>
set dir=~/.vim      " Location for .swp files
let mapleader = "\<Space>"

" Searching
set ignorecase      " Case insensitive search
set smartcase       " Ignore ignorecase
set hlsearch        " Show search results
" set wrapscan        " Continue search at the top
set nowrapscan        " do not wrap around
set incsearch       " Incremental search

" Textformatting, indenting, tabs
" scriptencoding utf-8
" set encoding=utf-8
set textwidth=80    " Yay, history!
" set wrapmargin=0
set autoindent      " ...
set smartindent     " ...
set tabstop=2       " Number of spaces per tab
set shiftwidth=2    " Default number of spaces for >> and <<
set softtabstop=2   " Number of spaces per tab
set expandtab       " Spaces instead of tabs
set smarttab        " Add/remove spaces instead of tabs
set linebreak       " Break lines nicer
set number          " Show line numbers
set listchars=tab:»\ ,trail:·,eol:¬

" Highlighting, colors, fonts
let g:tex_conceal = ""
syntax enable
set t_Co=256

if has("gui_running")
    set lines=60                " More lines ...
    set columns=120             " and columns in GUI mode
    set gfn=Monospace\ 12
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=b
endif
" for ise synthesis report
au BufReadPost *.syr set syntax=html
" Folding
set foldenable
set foldmethod=marker
"may cause problem with tmux
set fillchars=fold:-

" Omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menu
set complete=kspell,d,w,b
" for vimdiff
if &diff
  "diff mode
  set diffopt+=iwhite
endif
"}}}
"{{{ Plugins


filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim' "{{{

let g:lightline = {
    \ 'component': {
    \   'readonly': '%{&readonly?"✖":""}',
    \ },
    \ 'active': {
    \   'right': [['lineinfo'], ['percent']],
    \ },
    \ }

"}}}
Plug 'justinmk/vim-sneak' "{{{

let g:sneak#streak = 1

hi link SneakPluginTarget Type
hi link SneakPluginScope Function
hi link SneakStreakTarget Type
hi link SneakStreakMask Function

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"}}}
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } "{{{
let g:goyo_margin_top = 0
let g:goyo_margin_bottom = 0
let g:goyo_width = 95
"}}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "{{{
Plug 'junegunn/fzf.vim'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.fzf-history'
" configure fzf mappins
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <c-p> :Files<CR>
nnoremap <c-s> :Ag <C-R><C-W><CR>
nnoremap <Leader>be :Buffers<CR>
nnoremap <Leader>le :Lines <C-R><C-W><CR>
nnoremap <Leader>fe :Ag<CR>
"}}}
" Plug 'ctrlpvim/ctrlp.vim' "{{{
"
" let g:ctrlp_map = '<C-p>'
" let g:ctrlp_switch_buffer = 0
" let g:ctrlp_extensions = ['tag']
" " open buffer in new tab
" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<c-t>'],
"     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"     \ }
"
" let g:ctrlp_user_command = {
"     \ 'types': {
"     \   1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
"     \   2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"     \ 'fallback': 'ag %s -l --nocolor -g ""'
"     \ }
" "}}}
Plug 'mileszs/ack.vim' "{{{
" let g:ackprg="ag --nogroup --nocolor --column"
let g:ackprg="ag -S --nogroup --nocolor --column"
let g:ack_use_dispatch = 1
"}}}
Plug 'tpope/vim-dispatch'"{{{
"}}}
Plug 'reedes/vim-wordy' "{{{
"}}}
Plug 'spolu/dwm.vim' "{{{
let g:dwm_map_keys = 1

nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-N> <Plug>DWMNew
nmap <C-X> <Plug>DWMClose
nmap <C-L> <Plug>DWMGrowMaster
nmap <C-H> <Plug>DWMShrinkMaster
nmap <C-E> <Plug>DWMFocus
"}}}
Plug 'tomtom/tcomment_vim' "{{{
"}}}
Plug 'tpope/vim-surround' "{{{
"}}}
" Plug 'jlanzarotta/bufexplorer' "{{{
"}}}
Plug 'jiangmiao/auto-pairs' "{{{
"}}}
Plug 'Shougo/neosnippet-snippets' "{{{
"}}}
Plug 'Shougo/neosnippet' "{{{
let g:neosnippet#snippets_directory='~/.vim/snippets'

imap <C-e>          <Plug>(neosnippet_expand_or_jump)
smap <C-e>          <Plug>(neosnippet_expand_or_jump)
"}}}
"{{{ Plug more colors
Plug 'vim-scripts/CycleColor'
" Plug 'yantze/pt_black'
" Plug 'sjl/badwolf'
" Plug 'chriskempson/vim-tomorrow-theme'
Plug 'itchyny/landscape.vim'
Plug 'vim-scripts/lilypink'
Plug 'flazz/vim-colorschemes'
"}}}
Plug 'Yggdroot/indentLine' "{{{
let g:indentLine_enabled = 0
let g:indentLine_color_term = 239
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
"}}}
Plug 'matze/vim-move' "{{{
let g:move_map_keys = 0

vmap <A-j> <Plug>MoveBlockDown
vmap <A-k> <Plug>MoveBlockUp
vmap j <Plug>MoveBlockDown
vmap k <Plug>MoveBlockUp
"}}}
"{{{ vim-erlang-omnicomplete
Plug 'vim-erlang/vim-erlang-omnicomplete'
"}}}
"{{{ neco-look
Plug 'ujihisa/neco-look'
"}}}
if has('lua')
    Plug 'Shougo/neocomplete' "{{{neocomplete
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#manual_completion_start_length = 2
    let g:neocomplete#max_list = 20
    let g:neocomplete#sources#syntax#min_keyword_length = 2

		if !exists('g:neocomplete#sources')
		  let g:neocomplete#sources = {}
		endif
    " " let g:neocomplete#sources#dictionary#dictionaries = {
    " "       \ 'default' : '',
    " "       \ 'mail' : '~/.vim/spell/pg3202.txt',
    " "       \ }
    " " let g:neocomplete#sources#dictionary#dictionaries = {
    " "       \ 'default' : '',
    " "       \ }
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
    endfunction

    inoremap <silent><CR>   <C-r>=<SID>my_cr_function()<CR>

    nmap <Leader>nce :NeoCompleteEnable<CR>
    nmap <Leader>ncd :NeoCompleteDisable<CR>

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    " let g:neocomplete#force_omni_input_patterns.erlang =
    "       \'\h\w\+\|[^.[:digit:] *\t]\%(\.\|->\)'
      " \'\h\w*'
" \'\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'

    " inoremap <C-Space> <C-x><C-o>
    " inoremap <C-@> <C-Space>
    "}}}
else
    Plug 'Shougo/neocomplcache' "{{{neocomplcache
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_auto_select = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_auto_completion_start_length = 3
    let g:neocomplcache_manual_completion_start_length = 3
    let g:neocomplcache_min_syntax_length = 3

    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction

  inoremap <silent><CR>   <C-r>=<SID>my_cr_function()<CR>

  nmap <Leader>nce :NeoComplCacheEnable<CR>
  nmap <Leader>ncd :NeoComplCacheDisable<CR>
endif
  "}}}
"{{{ Shougo neocomplete plugins
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'davidhalter/jedi-vim' "{{{
  autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	let g:neocomplete#force_omni_input_patterns.python =
	\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" alternative pattern: '\h\w*\|[^. \t]\.\w*'

"}}}
"}}}
Plug 'beloglazov/vim-online-thesaurus' "{{{
let g:online_thesaurus_map_keys = 0
"}}}
"{{{ YouCompleteMe
" Plug 'Valloric/YouCompleteMe'
" let g:ycm_auto_trigger = 1
" let g:ycm_min_num_of_chars_for_completion = 2
" let g:ycm_semantic_triggers =  {
"     \   'erlang' : [':']
" \ }
" let g:ycm_complete_in_comments = 1
"}}}
call plug#end()
silent! colorscheme CandyPaper
"use // instead of /**/ for c
call tcomment#DefineType('c','// %s')
call tcomment#DefineType('v','// %s')
"}}}
"{{{ Functions
function! HighlightAnnotations()
  syn keyword verilogTodo contained FIXME TODO HACK DBG
endfunction
autocmd Syntax * call HighlightAnnotations()

function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction
"}}}
"{{{ Syntax for odd files
au BufRead,BufNewFile *.vh setfiletype verilog
au BufRead,BufNewFile *.do set syntax=expect
"add more syntax annotations for verilog
"}}}
"{{{ Keymaps
"map paste to always paste the last yanked value
xnoremap p pgvy
noremap Y "ay
noremap P "ap
"to expand fold with CR
nnoremap <CR> za
" select pasted text
noremap gV `[v`]
nnoremap <C-f> :Ack! <C-r><C-w><CR><CR>
" nnoremap <C-b> :CtrlPTag<CR>
"move vertically by visual line
nnoremap j gj
nnoremap k gk

"switch between buffers
nmap <Right> :bn<CR>
nmap <Left> :bp<CR>
"swith between tabs, weird letters are for xterm 
nnoremap <A-i> <Esc>:tabp<CR>
nnoremap <A-o> <Esc>:tabn<CR>
nnoremap é :tabp<CR>
nnoremap ï :tabn<CR>
"move in windows normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap è <C-w>h
nnoremap ê <C-w>j
nnoremap ë <C-w>k
nnoremap ì <C-w>l
"move tabs
nnoremap <A-n> <Esc>:tabm +1<CR>
nnoremap <A-p> <Esc>:tabm -1<CR>
nnoremap î <Esc>:tabm +1<CR>
nnoremap ð <Esc>:tabm -1<CR>

" remap . to enable repeting the last command on all selected lines
vnoremap . :norm.<CR>

" au BufEnter,BufNew *.tex nnoremap <F5> <Esc>:w!<CR>:Dispatch<CR>
" au BufEnter,BufNew *.v nnoremap <F5> <Esc>:w!<CR>:! vlog -work /home/uros/Uros/modelsim_tmp/work % <CR>
nnoremap <F5> <Esc>:w!<CR>:Dispatch!<CR>

nnoremap <Leader>w :w!<CR>
nnoremap <Leader>h :silent noh<CR>
nnoremap <Leader>H :hi Folded ctermbg=None<CR>

nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>

"spell checking bindings
nmap <Leader>se :setlocal spell spelllang=en_us<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>
nmap <Leader>ss 1z=
" set only underline for local spelling
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
nnoremap <Leader>t :OnlineThesaurusCurrentWord<CR> 

" delete current buffer
nmap <Leader>q :bd<CR>
" nmap <Leader>b :buffers<CR>:buffer<Space>
nmap <Leader>x :call DeleteEmptyBuffers()<CR>
" nmap <Leader>e :Explore<CR>
nmap <Leader>ig :IndentLinesToggle<CR>
nmap <Leader>g :Goyo<CR>

" copy/paste between vim sessions
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
nmap <Leader>y "+y
nmap <Leader>d "+d
nmap <Leader>p "+p
vmap <Leader>Y "*y
vmap <Leader>P "*p
vmap <Leader>D "*d
nmap <Leader>Y "*y
nmap <Leader>P "*p
nmap <Leader>D "*d
nmap         D "_x
vmap         D "_x
"for vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
"toggle pastemode to avoid indent
" set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


"}}}
"{{{ Autocmds
" Allow using <CR> on quickfix entries
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Show quickfix after :make, taken from
" http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
autocmd QuickFixCmdPost [^l]*   nested  cwindow
autocmd QuickFixCmdPost l*      nested  lwindow

" Reset fold background to reduce distraction
autocmd VimEnter * hi Folded ctermbg=None

" Uncomment the following to have Vim jump to the last position when
" reopening a file (from /etc/vim/vimrc
if has("autocmd")
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" to fix json highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript
"}}}

"===========================
" General Settings         "
"===========================
set nocompatible " Use Vim settings, not Vi
"filetype on      " Explicitly turn on to not get an error in OSX before turning off.
filetype off     " Required for Vundle

" Required for extended % matching!
runtime macros/matchit.vim

"===========================
" Vundle Configuration     "
"===========================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" My Custom Plugins Below....
Plugin 'dense-analysis/ale' " Asynchronous Lint Engine

Plugin 'AndrewRadev/splitjoin.vim' " Commands for changing from single to multi line statements
Plugin 'bling/vim-airline' " Lean & mean status/tabline for vim that's light as air.
Plugin 'chriskempson/base16-vim' " 16 color syntax highlighting themes
Plugin 'christoomey/vim-tmux-runner' " Send commands from vim to tmux
Plugin 'elixir-lang/vim-elixir' " Elixir support
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'inside/vim-grep-operator' " Visual and motion selection for grep
Plugin 'janko-m/vim-test' " Vim wrapper for test running (RSpec, Minitest, etc)
Plugin 'kana/vim-textobj-user' " Create text objects easily (see below for ruby)
Plugin 'kien/ctrlp.vim' " Super fast file finding
Plugin 'lokaltog/vim-easymotion' " Targeted content navigation
Plugin 'maxmellon/vim-jsx-pretty' " React syntax/highlighting/indent
Plugin 'mhinz/vim-mix-format' " Support for asynchronously running mix format
Plugin 'nelstrom/vim-textobj-rubyblock' " Easilly select ruby text blocks
Plugin 'ngmy/vim-rubocop' " Rubocop support
Plugin 'rking/ag.vim' " Super fast file searching
Plugin 'scrooloose/nerdtree' " NerdTree!
Plugin 'tpope/vim-endwise' " Automatically add end syntax to if, do, etc.
Plugin 'tpope/vim-fugitive' " Git commands wrapper for Vim
Plugin 'tpope/vim-rails' " Vim support for navigating, editing and working w/ Rails
Plugin 'tpope/vim-surround' " Change, add, delete surrounding chars
Plugin 'vim-ruby/vim-ruby' " For editing and compiling Ruby within Vim
Plugin 'yuezk/vim-js' " JS syntax highlighting

call vundle#end()

"===========================
" Other Settings           "
"===========================
set backspace=indent,eol,start
set guicursor=  " Reset cursor settings
set ttyfast
set t_Co=256

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" By default go with 2 spaces for tabs unless otherwise specified.
set tabstop=2     " Number of spaces to add when tab pressed
set shiftwidth=2  " Number of spaces to add during indentation
set softtabstop=2 " Make the delete key treat 4 spaces as a tab
set expandtab     " Insert spaces when tab pressed

" Show the line numbers and ruler
set number
set ruler
set relativenumber

" Show the status bar and set up specific colors
set laststatus=2

set colorcolumn=80

highlight StatusLine ctermfg=Gray
highlight LineNr ctermfg=DarkGray
highlight CursorLineNr ctermbg=DarkGray

" Map the leader key to SPACE
let mapleader=","

autocmd InsertEnter * highlight StatusLine ctermfg=Green
autocmd InsertLeave * highlight StatusLine ctermfg=Gray
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Strip Trailing Whitespace!
autocmd BufWritePre * :%s/\s\+$//e

" Use the patched powerline-fonts
let g:airline_powerline_fonts = 1
" Show errors/warnings from ALE on the status line.
let g:airline#extensions#ale#enabled = 1

" vim-tmux-runner
let g:VtrClearSequence = "clear\r"

" vim-test - use vim-tmux-runner as the test strategy
let test#strategy = 'vtr'
let test#python#runner = 'pytest'
map <leader>a :TestSuite<CR>
map <leader>g :TestVisit<CR>
map <leader>l :TestLast<CR>
map <leader>s :TestNearest<CR>
map <leader>t :TestFile<CR>

" == Remappings ==
"
" Save File w/ leader + s
noremap <leader>w :w<cr>
inoremap <leader>w <C-c>:w<cr>

" Quit w/ leader + q
noremap <leader>q :q<cr>
noremap <leader>wq :wq<cr>
noremap <leader>q! :q!<cr>

" Switch windows easier - left home row
nmap <leader>a <C-w><Up>
nmap <leader>o <C-w><Down>
nmap <leader>e <C-w><Left>
nmap <leader>u <C-w><Right>

" My rubocop-git script to compare with develop
nmap <leader>rgd :!rubocop-git-vs-develop<CR>
nmap <leader>rgm :!rubocop-git-vs-master<CR>
nmap <leader><leader>rgd :!rcop-current-file-vs-develop %<CR>
nmap <leader><leader>rgm :!rcop-current-file-vs-master %<CR>

nnoremap <leader>oN :NERDTree<CR>
nnoremap <leader>cN :NERDTreeClose<CR>
nnoremap <leader>tN :NERDTreeToggle<CR>

" Open a new terminal pane
nmap <leader>vt :vsplit \| term<CR>
nmap <leader>st :split \| term<CR>

" Some search help!
nmap <F2> :set hlsearch!<CR>

" VimTmuxRunner
nmap <leader>kr :VtrKillRunner<CR>
nmap <leader>or :VtrOpenRunner({'orientation': 'h', 'percentage': 30})<CR>

" Directional stuff!!
" I use h=left, t=right j=down, k=up
nmap t <Right>
vmap t <Right>

" Let's enable copy past via commands using pbcopy/paste
nmap <F3> :.w !pbcopy<CR>
nmap <F4> :r !pbpaste<CR>
imap <F4> <ESC>:r !pbpaste<CR>

" Format on save so we don't forget
let g:mix_format_on_save = 1

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'javascriptreact': ['prettier', 'eslint'],
\   'ruby': ['rubocop']
\}


" CtrlP
let g:in_git = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), "\n*$", '', '')
if g:in_git != ''
  cd `=g:in_git`
  let g:ctrlp_user_command = 'cd %s && git ls-files . -co --exclude-standard'
endif

" Added matcher for better fuzzy search - https://github.com/burke/matcher
if executable('matcher')
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }

  function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")

  endfunction
endif

" Automatically pick up on what the terminal is configured to use.
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"===========================
" General Settings         "
"===========================
set nocompatible " Use Vim settings, not Vi
filetype on      " Explicitly turn on to not get an error in OSX before turning off.
filetype off     " Required for Vundle

" Required for extended % matching!
runtime macros/matchit.vim

"===========================
" Vundle Configuration     "
"===========================

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" My Custom Plugins Below....
Plugin 'vim-ruby/vim-ruby' " For editing and compiling Ruby within Vim
Plugin 'tpope/vim-rails' " Vim support for navigating, editing and working w/ Rails
Plugin 'tpope/vim-fugitive' " Git commands wrapper for Vim
Plugin 'tpope/vim-surround' " Change, add, delete surrounding chars
Plugin 'tpope/vim-endwise' " Automatically add end syntax to if, do, etc.
Plugin 'scrooloose/nerdtree' " NerdTree!
Plugin 'kien/ctrlp.vim' " Super fast file finding
Plugin 'rking/ag.vim' " Super fast file searching
Plugin 'lokaltog/vim-easymotion' " Targeted content navigation
Plugin 'janko-m/vim-test' " Vim wrapper for test running (RSpec, Minitest, etc)
Plugin 'AndrewRadev/splitjoin.vim' " Commands for changing from single to multi line statements
Plugin 'kchmck/vim-coffee-script' " CoffeeScript support
Plugin 'inside/vim-grep-operator' " Visual and motion selection for grep
Plugin 'ngmy/vim-rubocop' " Rubocop support
Plugin 'chriskempson/base16-vim' " 16 color syntax highlighting themes
Plugin 'scrooloose/syntastic' " Syntax checking and visual output (warnings, errors, etc)
Plugin 'elixir-lang/vim-elixir' " Elixir support
Plugin 'kana/vim-textobj-user' " Create text objects easily (see below for ruby)
Plugin 'nelstrom/vim-textobj-rubyblock' " Easilly select ruby text blocks
Plugin 'benekastah/neomake' " Asynchronous :make support, for syntax, rubocop, etc
Plugin 'christoomey/vim-tmux-runner' " Send commands from vim to tmux
Plugin 'bling/vim-airline' " Lean & mean status/tabline for vim that's light as air.

call vundle#end()

"===========================
" Other Settings           "
"===========================
set ttyfast
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-atelier-lakeside

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" By default go with 4 spaces for tabs unless otherwise specified.
set tabstop=4     " Number of spaces to add when tab pressed
set shiftwidth=4  " Number of spaces to add during indentation
set softtabstop=4 " Make the delete key treat 4 spaces as a tab
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

" Run neomake after writing.
autocmd! BufWritePost * Neomake

"===========================
" Ruby Specific Settings   "
"===========================
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2

" Use the pached powerline-fonts
let g:airline_powerline_fonts = 1

" vim-tmux-runner
let g:VtrClearSequence = "clear\r"

" vim-test - use vim-tmux-runner as the test strategy
let test#strategy = "vtr"
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
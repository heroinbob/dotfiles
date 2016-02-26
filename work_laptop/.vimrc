"===========================
" General Settings         "
"===========================

set nocompatible " Use Vim settings, not Vi
filetype on      " Explicitly turn on to not get an error in OSX before turning off.
filetype off     " Required for Vundle

"===========================
" Vundle Configuration     "
"===========================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" My Custom Plugins Below....
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'lokaltog/vim-easymotion'
Plugin 'thoughtbot/vim-rspec'
Plugin 'godlygeek/tabular'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'inside/vim-grep-operator'
Plugin 'ngmy/vim-rubocop'
Plugin 'chriskempson/base16-vim'
Plugin 'scrooloose/syntastic'
Plugin 'elixir-lang/vim-elixir'

call vundle#end()

"===========================
" Other Settings           "
"===========================
set ttyfast
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-atelierlakeside

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

highlight StatusLine ctermfg=Gray
highlight LineNr ctermfg=DarkGray
highlight CursorLineNr ctermbg=DarkGray

autocmd InsertEnter * highlight StatusLine ctermfg=Green
autocmd InsertLeave * highlight StatusLine ctermfg=Gray
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Strip Trailing Whitespace!
autocmd BufWritePre * :%s/\s\+$//e

"===========================
" Ruby Specific Settings   "
"===========================
autocmd FileType ruby compiler ruby
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2


"==========="
" Vim RSpec "
"==========="
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "Dispatch bundle exec spring rspec -I . {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" == Remappings ==
"
" Save File w/ leader + s
noremap <leader>w :w<cr>
inoremap <leader>w <C-c>:w<cr>

" Quit w/ leader + q
noremap <leader>q :q<cr>
noremap <leader>wq :wq<cr>
noremap <leader>q! :q!<cr>

" Tabularize Alignments
noremap <leader>t{ Tabularize /{\zs<CR>
noremap <leader>t= Tabularize /=\zs<CR>
noremap <leader>t: Tabularize /:\zs<CR>
noremap <leader>t, Tabularize /,\zs<CR>

" I like turtles
set grepprg=git\ grep\ -n\ $*
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt

" Switch windows easier
nmap <leader><Up> <C-w><Up>
nmap <leader><Right> <C-w><Right>
nmap <leader><Left> <C-w><Left>
nmap <leader><Down> <C-w><Down>

" My rubocop-git script to compare with develop
nmap <leader>rgd :!rubocop-git-vs-develop<CR>
nmap <leader>rgm :!rubocop-git-vs-master<CR>
nmap <leader><leader>rgd :!rcop-current-file-vs-develop %<CR>
nmap <leader><leader>rgm :!rcop-current-file-vs-master %<CR>

nnoremap <leader>oN :NERDTree<CR>
nnoremap <leader>cN :NERDTreeClose<CR>


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

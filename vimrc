set nocompatible

""Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo"'
set nofoldenable
set foldmethod=manual

" In many terminal emulators the mouse works just fine, thus enable it.
set ttymouse=xterm2
if has('mouse')
  set mouse=a
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"Macros

" Pathogen
filetype off
call pathogen#infect('bundle/{}')
call pathogen#helptags()

"General
if has("gui_running") || &term == "xterm-256color" || &term == "screen-256color"
  set t_Co=256
  set selectmode=key
  colo wombatmikemod
else
  colo wombat
  let vimrplugin_screenplugin = 0
  let vimrplugin_conqueplugin = 1
endif

syntax enable
syntax on
syntax sync fromstart

filetype plugin on
filetype indent on

set guioptions-=b
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=T
set guicursor=

set encoding=utf-8

set ai "autoindent
set si "smartindent

set ofu=syntaxcomplete#Complete

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

  let g:miniBufExplMapWindowNavVim = 1
  let g:miniBufExplMapWindowNavArrows = 1
  let g:miniBufExplMapCTabSwitchBufs = 1
  let g:miniBufExplModSelTarget = 1

set tabstop=2
set shiftwidth=2
set cindent shiftwidth=2

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha
set expandtab

" Set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

set list!
set listchars=tab:^^

" Show way cooler status line

set laststatus=2
set statusline=%<%F\ %h%m%r%h%w%y\ %{fugitive#statusline()}%=\ col:%c%V\ %P

" Use F10 to toggle 'paste' mode
set pastetoggle=<F10>

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Fix my <Backspace> key (in Mac OS X Terminal)
set t_kb=
fixdel

set cursorline
set smartcase

set shellredir=>%s\ 2>&1

set lazyredraw

set showfulltag

set ruler
set number
set virtualedit=all
set showmatch matchtime=2
set history=5000
set updatetime=1000
set backup
set incsearch
set nohlsearch
set wrapscan
set nowrap
set showcmd
set wildignore+=*.pyc,*.o,*.class

autocmd FileType tex setlocal textwidth=80
autocmd BufNewFile,BufRead *.txt setlocal textwidth=80

if version >= 700
  "autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
  "autocmd FileType tex setlocal spell spelllang=en_us
endif

" Set backup and undo
if v:version >= 703
  :if !isdirectory($HOME . "/.temp")
  :  call mkdir($HOME . "/.temp", "")
  :  call mkdir($HOME . "/.temp/swap", "")
  :  call mkdir($HOME . "/.temp/backup", "")
  :  call mkdir($HOME . "/.temp/undo", "")
  :endif

  set directory=$HOME/.temp/swap
  set backupdir=$HOME/.temp/backup

  set undodir=$HOME/.temp/undo
  set undofile
  set undoreload=50000
endif
set undolevels=1000

set wildmenu
set wildmode=list:longest,full

set scrolloff=8


"if has("gui")
  " MacVim Fullscreen
  "set fuopt+=maxhorz
"endif

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" Make completion easier

set completeopt=menuone,longest,preview

inoremap <C-F> <C-X><C-F>

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" exVim Settings
let g:ex_usr_name = "Mike Dacre"

""" My Functions

" Sort
map <leader>ss :sort<cr>
map <leader>su :!sort -u<cr>

" Tidy up pargraphs
vmap Q gq
nmap Q gqap

" Tab stuff
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Add cmdlst syntax
fun CaptureLine()
  let l = getline('.')
  let c = system( l )
  set paste
  set noexpandtab
  exe "normal o".c
  set nopaste
  set expandtab
  "redraw!
endfun

fun ExecLine()
  let l = getline('.')
  set paste
  set noexpandtab
  exe "normal o###"
  exe "normal o# "
  exe "normal o# Run start: ".strftime("%y-%m-%d %H:%M:%S")
  exe "normal o# "
  exe "normal o###"
  exe "normal o# Output:::"
  exe "normal o# "
  let c = system( l )
  let c = substitute(c, '^', '# ', 'g')
  let c = substitute(c, '\n', '\r# ', 'g')
  exe "normal o".c
  exe "normal o###"
  exe "normal o# "
  exe "normal o# Run end ".strftime("%y-%m-%d %H:%M:%S")
  exe "normal o# "
  exe "normal o###"
  set nopaste
  set expandtab
  redraw!
endfun

au BufRead,BufNewFile *.cmdlst set filetype=sh
au BufRead,BufNewFile *.pbs set filetype=sh
noremap <leader>il :call CaptureLine()<CR>
noremap <leader>el :call ExecLine()<CR>

" Date inserting
nnoremap <leader>dd "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
inoremap <leader>dd <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

nnoremap <leader>ds "=strftime("%m/%d/%y")<CR>P
inoremap <leader>ds <C-R>=strftime("%m/%d/%y")<CR>

nnoremap <leader>dt "=strftime("%T")<CR>P
inoremap <leader>dt <C-R>=strftime("%T")<CR>

nnoremap <leader>dl "=strftime("%a %d %b %Y %X %Z")<CR>P
inoremap <leader>dl <C-R>=strftime("%c")<CR>

" My tag
nnoremap <leader>me iMike Dacre
inoremap <leader>me Mike Dacre

fun InsertCmd( cmd )
       let l = system( a:cmd )
       let l = substitute(l, '\n$', '', '')
       exe "normal a".l
       redraw!
endfun

nnoremap <leader>my iMike Dacre <C-R>=strftime("%y-%m-%d %H:%M:%S")<CR> <ESC>
inoremap <leader>my Mike Dacre <C-R>=strftime("%y-%m-%d %H:%M:%S")<CR>

nnoremap <leader>mh :call InsertCmd( 'hostname' )<CR><RIGHT>
inoremap <leader>mh <C-O>:call InsertCmd( 'hostname' )<CR><RIGHT>

" Pasting Mode
map <leader>pp :set paste<CR>:set noexpandtab<CR>
map <leader>PP :set nopaste<CR>:set expandtab<CR>

" Delete starting whitespace
map <leader>ds :s/^\s\+<CR>

" Templates
let g:template_basedir = "~/.vim/templates"

" Last Modified function
autocmd BufWritePre,FileWritePre *   ks|call LastMod()|'s
fun LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " .
  \ strftime("%Y-%m-%d %H:%M")
endfun

" Send line to Tmux
fun StartScreenTmux()
  if !g:ScreenShellActive
    if &filetype == 'python' 
      :IPython
    elseif &filetype == 'python3'
      :IPython3
    else
      :ScreenShell
    endif
  endif 
endfun

fun SendLine()
  call StartScreenTmux()
  let c = getline('.')
  call g:ScreenShellSend(c)
endfun

fun SendSelectionDedent()
  call StartScreenTmux()
  let c = substitute(@v, '\t', '  ', 'g')
  let c = substitute(c, '^ \+', '', 'g')
  let c = substitute(c, '\r \+', '\n', 'g')
  let c = substitute(c, '\n \+', '\n', 'g')
  call g:ScreenShellSend(c)
endfunction

fun SendCellPython()
  call StartScreenTmux()
  :?##\|\#^?;/##\|\#$/y b
  call g:ScreenShellSend(@b)
endfun

map <C-e> :call StartScreenTmux()<cr>
nmap <silent> <Space> :call SendLine()<cr>
vmap <silent> <Space> :ScreenSend<cr>
nmap <silent> <LocalLeader>sc :call SendCellPython()<cr>
vmap <silent> <LocalLeader>sd "vy :call SendSelectionDedent()<CR>

"Protect large files from sourcing and other overhead.
let g:LargeFile=100
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)

  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>")
    if getfsize(expand("<afile>")) > g:LargeFile*1024*1024
      syn clear
      set eventignore+=FileType
      setlocal bufhidden=unload undolevels=-1 fdm=manual
      noplugin
      echomsg "***note*** handling a large file"
    else
      set eventignore-=FileType
    endif
  augroup END
endif

" VimTip 329: A map for swapping words
" http://vim.sourceforge.net/tip_view.php?tip_id=
" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <unique> <silent><leader>sw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

""" Language and Plugin Config

" Template for specific files
au BufNewFile  *Process.txt 0r ~/.vim/templates/process_TEMPLATE
"au BufRead,BufNewFile *.txt set filetype=pandoc
au FileType pandoc setlocal tw=99 tabstop=4 shiftwidth=4 softtabstop=4
au BufRead,BufNewFile *.md set filetype=mmd
au BufRead,BufNewFile *.rst set filetype=rst
au BufNewFile * silent! 0r ~/.vim/templates/tmpl.%:e

" Add fasta syntax
au! Syntax newlang source $VIM/syntax/fasta.vim
au BufRead,BufNewFile *.fa set filetype=fasta
au BufRead,BufNewFile *.fasta set filetype=fasta
au BufRead,BufNewFile *.afa set filetype=fasta
au BufRead,BufNewFile *.pep set filetype=fasta

" PHP Syntax
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1

" PgSQL
au BufNewFile,BufRead *.pgsql                   setf pgsql

" Python
au BufRead,BufNewFile *.py set filetype=python

autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Jedi
let g:jedi#force_py_version = 3
noremap <leader>gg :call jedi#goto_assignments()
noremap <leader>gd :call jedi#goto_definitions()
noremap <leader>rn :call jedi#rename()

" Perl
autocmd FileType perl set omnifunc=perlcomplete#Complete

" Table Mode
let g:table_mode_fillchar = '='
let g:table_mode_separator = '#'
let g:table_mode_toggle_map = '<leader>tb'
let g:pandoc_no_folding = 1
let g:pandoc_bibfiles = ['/Users/dacre/bib/Altitude.bib']

" NERDtree
noremap <F5> :NERDTree<CR>
let g:NERDTreeWinPos = "right"

" Sessions
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Session
noremap <leader>ss :SessionSave<CR>
noremap <leader>so :SessionOpen

" SnipMate
let g:snips_author = 'Mike Dacre'

" vim-ipython

" Vimux
noremap <silent> <leader>vp :VimuxPromptCommand<CR>
noremap <silent> <leader>vr :VimuxRunLastCommand<CR>
noremap <silent> <leader>vi :VimuxInspectRunner<CR>
noremap <silent> <leader>vk :VimuxInterruptRunner<CR>
noremap <silent> <leader>vx :VimuxClosePanes<CR>
vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>

" Tag List
noremap <F6> :TlistToggle<CR>
map <leader>to :TlistSessionLoad .tlist<cr>
map <leader>ts :TlistSessionSave .tlist<cr>y<cr>
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Use_Right_Window = 0
let Tlist_Process_file_Always = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'
let tlist_python3_settings = 'Python;c:classes;f:functions;m:class_members;v:variables;i:imports'

" Task List
map <leader>tl <Plug>TaskList

" Gundo
map <leader>gu :GundoToggle<CR>

" mark (special) text
let g:ex_todo_keyword = 'NOTE REF EXAMPLE SAMPLE CHECK TIPS HINT'
let g:ex_comment_lable_keyword = 'DELME TEMP MODIFY ADD KEEPME DISABLE TEST ' " for editing
let g:ex_comment_lable_keyword .= 'ERROR DEBUG CRASH DUMMY UNUSED TESTME ' " for testing
let g:ex_comment_lable_keyword .= 'FIXME BUG HACK OPTME HARDCODE REFACTORING DUPLICATE REDUNDANCY PATCH ' " for refactoring

" Buffer Explorer
let g:bufExplorerFindActive=1
map <leader>be :BufExplorer<CR>

" R Plugin
"let g:vimrplugin_notmuxconf = 1
let g:vimrplugin_vsplit = 1
let g:ScreenImpl = 'Tmux'
nmap <LocalLeader>ll <Plug>RSendLine

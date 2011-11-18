set nocompatible

""Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo"'

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" allow backspacing over everything in insert mode
set backspace+=indent,eol,start

"Macros
let @f = ':%s/^/>/g:%s/\t/\r/g:set filetype=fasta'
let @i = ':%s/^\([^_]*\)_\([^_]*\)_\([^_]*\)_\([^_]*\)_.*$/\4'
let @k = ':%s/^\([^_]*\)_\([^_]*\)_\([^_]*\)_\([^_]*\)\S*\t\(.*\)$/\4\t\5:%s/\t/%$#/g:%s/%$#/\t'
let @t = ':%s/^\([^\t]\+\)\t.*\t\(\S\+\)$/\1\t\2/g'
let @l = 'ggdd:%s/.*\t:%s/%$#/\t/g'
let @c = ':%s/\t/%$#/g:%s/%$#/\t'
let @t = ':%s/^\(>.\+\)\n/\1\t:%s/\n//g:%s/[>\t]/\r/gset filetype=textggdd' 

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
 
"General
if has("gui_running") || &term == "xterm-256color"
  set t_Co=256
  set selectmode=key
  colo wombat256mod
else
  let vimrplugin_conqueplugin = 0
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
set history=50000
set updatetime=1000
set backup
set incsearch
set hlsearch
set wrapscan
set nowrap
set showcmd

" Set backup and undo
:if !isdirectory($HOME . "/.temp")
:  call mkdir($HOME . "/.temp", "")
:  call mkdir($HOME . "/.swap", "")
:  call mkdir($HOME . "/.backup", "")
:  call mkdir($HOME . "/.undo", "")
:endif

set directory=$HOME/.temp/swap
set backupdir=$HOME/.temp/backup

set undodir=$HOME/.temp/undo
set undofile
set undolevels=1000
set undoreload=50000

set wildmenu
set wildmode=list:longest,full

set scrolloff=8


if has("gui")
  " MacVim Fullscreen
  set fuopt+=maxhorz
endif

" Set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

noremap <F5> :TlistToggle<CR>
noremap <F6> :NERDTree<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
"let Tlist_Use_Horiz_Window = 1
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Process_file_Always = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" Tab stuff
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Task List
map <leader>tl <Plug>TaskList

" Pasting Mode
map <leader>pp :set paste<CR>:set noexpandtab<CR>
map <leader>PP :set nopaste<CR>:set expandtab<CR>

" Copy line to clipboard
map <leader>ll "*y$
map <leader>lp "*p
map <leader>l  "*

" Delete starting whitespace
map <leader>ds :s/^\s\+<CR>

" Make filename completion easier
imap <C-F> <C-X><C-F>

" Date inserting
:nnoremap <leader>dd "=strftime("%d-%m-%y %H:%M:%S")<CR>P
:inoremap <leader>dd <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>

:nnoremap <leader>ds "=strftime("%m/%d/%y")<CR>P
:inoremap <leader>ds <C-R>=strftime("%m/%d/%y")<CR>

:nnoremap <leader>dt "=strftime("%T")<CR>P
:inoremap <leader>dt <C-R>=strftime("%T")<CR>

:nnoremap <leader>dl "=strftime("%a %d %b %Y %X %Z")<CR>P
:inoremap <leader>dl <C-R>=strftime("%c")<CR>

" My tag
:nnoremap <leader>me iMike Dacre 
:inoremap <leader>me Mike Dacre 

:function InsertCmd( cmd )
:       let l = system( a:cmd )
:       let l = substitute(l, '\n$', '', '')
:       exe "normal a".l
:       redraw!
:endfunction

:nnoremap <leader>my iMike Dacre (Salk @<C-O>:call InsertCmd( 'hostname' )<CR><RIGHT>) <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR> <ESC>
:inoremap <leader>my Mike Dacre (Salk @<C-O>:call InsertCmd( 'hostname' )<CR><RIGHT>) <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR> 

:nnoremap <leader>mh :call InsertCmd( 'hostname' )<CR><RIGHT>
:inoremap <leader>mh <C-O>:call InsertCmd( 'hostname' )<CR><RIGHT> 

" map Ctrl-Tab to switch window
nnoremap <unique> <S-Up> <C-W><Up>
nnoremap <unique> <S-Down> <C-W><Down>
nnoremap <unique> <S-Left> <C-W><Left>
nnoremap <unique> <S-Right> <C-W><Right>

" Template for specific files
au BufNewFile  *Process.txt	0r ~/.vim/templates/process_TEMPLATE

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

" VimTip 329: A map for swapping words
" http://vim.sourceforge.net/tip_view.php?tip_id=
" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <unique> <silent><leader>sw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

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

" exVim Settings
let g:ex_usr_name = "Mike Dacre"
au FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.

set tags+=./tags,./../tags,./**/tags,tags,.vim/tags " which tags files CTRL-] will find
set makeef=error.err " the errorfile for :make and :grep


set foldmethod=marker foldmarker={,} foldlevel=9999
set diffopt=filler,context:9999


" mark (special) text
let g:ex_todo_keyword = 'NOTE REF EXAMPLE SAMPLE CHECK TIPS HINT'
let g:ex_comment_lable_keyword = 'DELME TEMP MODIFY ADD KEEPME DISABLE TEST ' " for editing
let g:ex_comment_lable_keyword .= 'ERROR DEBUG CRASH DUMMY UNUSED TESTME ' " for testing
let g:ex_comment_lable_keyword .= 'FIXME BUG HACK OPTME HARDCODE REFACTORING DUPLICATE REDUNDANCY PATCH ' " for refactoring

" PHP Specific Settings

" Reads the skeleton php file
" Note: The normal command afterwards deletes an ugly pending line and moves
" the cursor to the middle of the file.
autocmd BufNewFile *.php 0r ~/.vim/skeleton.php | normal Gdda

" Reads the skeleton txt file
autocmd BufNewFile *.txt 0r ~/.vim/skeleton.txt | normal GddOAOAOAOAOAOAOAOAOA
autocmd BufNewFile *.rst 0r ~/.vim/skeleton.txt | normal GddOAOAOAOAOAOAOAOAOA

" Python
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType perl set omnifunc=perlcomplete#Complete

let g:SuperTabDefaultCompletionType = "context"
let g:pep8_map='<leader>8'

set completeopt=menuone,longest,preview

" Searching
nmap <leader>a <Esc>:Ack!
map <leader>g :GundoToggle<CR>

" Sessions

set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

map <leader>be :BufExplorer<CR>


" Buffer Explorer
let g:bufExplorerFindActive=1 


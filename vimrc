set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/Vundle.vim
call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
" Plugin 'aperezdc/vim-template'
Plugin 'tpope/vim-obsession'
Plugin 'benmills/vimux'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'ervandew/screen'
Plugin 'gerw/vim-latex-suite'
Plugin 'jamessan/vim-gnupg'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jngeist/vim-multimarkdown'
Plugin 'junegunn/vim-easy-align'
Plugin 'MikeDacre/vim_todo_highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'othree/html5.vim'
Plugin 'Rykka/riv.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'Spaceghost/vim-matchit'
Plugin 'tpope/vim-surround'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-scripts/perl-support.vim'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'lepture/vim-jinja'
Plugin 'pangloss/vim-javascript'
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Git support
Plugin 'tpope/vim-fugitive'

" C Support
" Plugin 'MikeDacre/c-vim'

" Utilisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Python stuff
Plugin 'ervandew/supertab'
Plugin 'klen/python-mode'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
if has( 'python' )
  Plugin 'neilagabriel/vim-geeknote'
else
  Plugin 'Shougo/neocomplete.vim'
" Plugin 'davidhalter/jedi-vim'
endif

" Do tmux navigator last
Plugin 'christoomey/vim-tmux-navigator'

" Finish up
call vundle#end()            " required
filetype plugin indent on    " required

"General
if has("gui_running") || &term == "xterm-256color" || &term == "screen-256color"
  set t_Co=256
  set selectmode=key
  set guifont=Inconsolata\ Medium\ 15
  colo wombatmikemod
else
  colo wombat
  let vimrplugin_screenplugin = 0
  let vimrplugin_conqueplugin = 1
endif

syntax enable
syntax on
syntax sync fromstart

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
 
""Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"1000,:90,%,n~/.temp/viminfo"'
set nofoldenable
set foldmethod=syntax

" In many terminal emulators the mouse works just fine, thus enable it.
set ttymouse=xterm2
if has('mouse')
  set mouse=a
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
 
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
"set statusline=%<%F\ %h%m%r%h%w%y\ %{fugitive#statusline()}%=\ col:%c%V\ %P

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Allow continual indent/dedent in visual block
vnoremap < <gv
vnoremap > >gv

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
set wildmode=longest,list,full

" set scrolloff=8

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" Make completion easier

" Common path includers for file opening with gf
let &path.="src/include,include,"

set completeopt=menuone,longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" exVim Settings
let g:ex_usr_name = "Mike Dacre"

""" My Functions
" Diff attempt from
" http://vim.wikia.com/wiki/Create_patch_for_currently_editing_file

fu! TextWrapOn()
  set tw=79
  set formatoptions+=t
endf
fu! TextWrapOff()
  set tw=0
endf
nmap <leader>ww :call TextWrapOn()<cr>
nmap <leader>we :call TextWrapOff()<cr>

fu! DiffUnified()
  let diffexpr="diff -Nuar"
  let bname=bufname("")
  let origtemp=0
  " Case 1: File has a filename and is not modified
  if !&modified && !empty(bname)
    let tempfile=0
    let origFile=bname.".orig"
  else
    " Case 2: File has a filename and is modified
    if &modified && !empty(bname)
      if !filereadable(bname.".orig")
        sp
        enew
        r #
        0d
        let tempfile2=tempname()
        exe ":sil w! " .tempfile2
        wincmd q
        let origtemp=1
        wincmd p
      endif
      let origFile=tempfile2
      " Case 2: File is new and is modified
    else
      if &modified
        let origFile=bname.".orig"
      else
        let origFile=""
      endif
    endif
    let bname=tempname()
    exe ":sil w! ".bname
    let tempfile=1
  endif
  try
    if !filereadable(origFile)
      let origFile=input("With which file to diff?: ","","file")
    endif
    if !filereadable(bname)
      exe ":sil w! ".bname
    endif
    if empty(origFile)
      throw "nofile"
    endif
    exe "sil sp"
    exe "enew"
    set bt=nofile
    exe "sil r!".diffexpr." ".origFile." ".bname
    exe "0d_"
    exe "set ft=diff"
    " Clean up temporary files
    if  tempfile == 1
      exe "sil :!rm -f ". bname
      let tempfile=0
    endif
    if origtemp == 1
      exe "sil :!rm -f ". origFile
      let origtemp=0
    endif
  catch
  endtry
endf

" Fold with F
nmap <leader>F za

" Sort
vmap <leader>ss :sort<cr>
vmap <leader>su :!sort -u<cr>

" Tidy up pargraphs
vmap Q gq
nmap Q gqap

" Tab stuff
map <leader>tn :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove

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

" Delete training whitespace
" autocmd BufWritePre * :%s/\s\+$//e

" Templates
let g:templates_directory = "~/.vim/templates"
let g:templates_user_variables = [
        \   ['CWD', 'getcwd'],
        \ ]

" function! GetFullPath()
  " return expand('%:p')
" endfunction

" Last Modified function
let g:lastmodified = 1

map <leader>lm :call ToggleMod()<CR>
function! ToggleMod()
  if g:lastmodified
    let g:lastmodified = 0
    echom "Last modified editing switched off"
  else
    let g:lastmodified = 1
    echom "Last modified editing switched on"
  endif
endfun

function! LastModified()
  if &modified && g:lastmodified
      let save_cursor = getpos(".")
      let n = min([20, line("$")])
      keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified:\)\( [0-9]\{4}-[0-9]\{2}-[0-9]\{2} [0-9]\{2}:[0-9]\{2}\)\{,1}\(.*\)#\1 ' .
            \ strftime("%Y-%m-%d %H:%M") . '\3#e'
      call histdel('search', -1)
      call setpos('.', save_cursor)
  endif
endfun

autocmd BufWritePre * call LastModified()

" Send line to Tmux
let g:ScreenIPython3 = 1
let g:ScreenImpl = 'Tmux'
fun StartScreenTmux()
  if !g:ScreenShellActive
    if &filetype == 'python'
      let bang = a:0 ? a:1 : ''
      let g:ScreenShellSendPrefixOld = g:ScreenShellSendPrefix
      let g:ScreenShellSendSuffixOld = g:ScreenShellSendSuffix
      let g:ScreenShellSendPrefix = '%cpaste'
      let g:ScreenShellSendSuffix = '--'
      let g:ScreenShellSendVarsRestore = 1
      call screen#ScreenShell('ipython3', 'vertical')
      " call g:ScreenShellSend('%pylab')
    else
      call screen#ScreenShell('zsh', 'vertical')
    endif
  endif
endfun

fun OpenCloseScreen()
  if g:ScreenShellActive
    :ScreenQuit
  else
    call StartScreenTmux()
  endif
endfun

fun SendLine()
  if g:ScreenShellActive
    let c = getline('.')
    call g:ScreenShellSend(c)
  endif
endfun

fun SendSelectionDedent()
  if g:ScreenShellActive
    let c = substitute(@v, '\t', '  ', 'g')
    let c = substitute(c, '^ \+', '', 'g')
    let c = substitute(c, '\r \+', '\n', 'g')
    let c = substitute(c, '\n \+', '\n', 'g')
    call g:ScreenShellSend(c)
  endif
endfunction

fun SendCellPython()
  if g:ScreenShellActive
    :?##\|\#^?;/##\|\#$/y b
    call g:ScreenShellSend(@b)
  endif
endfun

map  <silent> <C-e> :call OpenCloseScreen()<cr>
nmap <silent> <Space> :call SendLine()<cr>
vmap <silent> <Space> :ScreenSend<cr>
smap <silent> <Space> <Nop>
nmap <silent> <LocalLeader>sa :ScreenSend<cr>
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

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors           = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

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

" Geeknote
let g:GeeknoteFormat="markdown"

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:vim_markdown_folding_disabled = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 0
let g:syntastic_aggregate_errors         = 1

if findfile('/usr/bin/pyflakes-python2')
  let pyflakes_python2 = 'pyflakes-python2'
else
  let pyflakes_python2 = 'pyflakes'
endif

let g:syntastic_python3_checkers         = ['python', 'pep8', 'py3kwarn', 'pyflakes3k', 'pylint']
let g:syntastic_python2_checkers         = ['python', 'pep8', 'py3kwarn', pyflakes_python2, 'pylint']
let g:syntastic_python3_small_checkers   = ['python', 'pep8', 'py3kwarn', 'pyflakes3k']
let g:syntastic_python2_small_checkers   = ['python', 'pep8', 'py3kwarn', pyflakes_python2]

let g:syntastic_quiet_messages = { 
    \ 'regex': ['bad-whitespace', 'W0612', 'C901', 'W0611', 'E221', 'E501', 'E116'] 
    \ }
let g:syntastic_python_pep8_quiet_messages = {'regex': 'E2[27]1'}
let g:syntastic_python_pylint_quiet_messages = {'regex': ['too-few-public-methods', 'too-many-statements', 'too-many-nested-blocks', 'superfluous-parens', 'bad-whitespace', 'too-many-instance-attributes', 'invalid-name', 'too-many-arguments', 'too-many-locals', 'too-many-branches', 'too-many-statements']}
let g:syntastic_python_pyflakes_quiet_messages = {'regex': ['']}

let g:syntastic_mode_map = { "mode": "passive" }

if has( 'python3' )
  let g:python_version = 3
  let g:syntastic_python_python_exec     = 'python3'
  let g:syntastic_python_checkers        = g:syntastic_python3_small_checkers
  let g:syntastic_python_checker         = 'long'
else
  let g:python_version = 2
  let g:syntastic_python_checkers        = g:syntastic_python2_small_checkers
  let g:syntastic_python_checker         = 'long'
endif

fun SynPy2()
  let g:python_version = 2
  let g:syntastic_python_python_exec     = 'python2'
  let g:syntastic_python_checkers        = g:syntastic_python2_checkers
endfun
fun SynPy3()
  let g:python_version = 3
  let g:syntastic_python_python_exec     = 'python3'
  let g:syntastic_python_checkers        = g:syntastic_python3_checkers
endfun

fun TogglePyCheckers()
  if g:syntastic_python_checker == 'long'
    if g:python_version == 2
      let g:syntastic_python_checkers    = g:syntastic_python2_small_checkers
    elseif g:python_mode == 3
      let g:syntastic_python_checkers    = g:syntastic_python3_small_checkers
    endif
    let g:syntastic_python_checker = 'short'
  elseif g:syntastic_python_checker == 'short'
    if g:python_version == 2
      let g:syntastic_python_checkers    = g:syntastic_python2_checkers
    elseif g:python_mode == 3
      let g:syntastic_python_checkers    = g:syntastic_python3_checkers
    endif
    let g:syntastic_python_checker = 'long'
  endif
endfun

fun ResetCheckers()
  SyntasticReset
  sign unplace *
  let g:pymode_lint_checkers = ['mccabe', 'pep257']
endfun
 

nmap <silent> <LocalLeader>pl :SyntasticCheck<cr>
nmap <silent> <LocalLeader>pk :SyntasticCheck pylint<cr>
nmap <silent> <LocalLeader>pu :call ResetCheckers()<cr>
nmap <silent> <LocalLeader>p2 :call SynPy2()<cr>
nmap <silent> <LocalLeader>p3 :call SynPy3()<cr>
nmap <silent> <LocalLeader>pt :call TogglePyCheckers()<cr>

let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 0

" Python
au BufRead,BufNewFile *.py set filetype=python
autocmd FileType python setlocal completeopt=menuone,longest
autocmd FileType python setlocal et sw=4 ts=4 tw=79 

" Jedi
let g:jedi#auto_initialization    = 0
if has( 'python' ) && has( 'python3' )
  let g:jedi#force_py_version     = 2
elseif has( 'python3' )
  let g:jedi#force_py_version     = 3
else
  let g:jedi#force_py_version     = 2
endif
" let g:jedi#popup_on_dot           = 1
" let g:jedi#auto_vim_configuration = 1
" let g:jedi#popup_select_first     = 0
noremap <leader>gg :call jedi#goto_assignments()<cr>
noremap <leader>gd :call jedi#goto_definitions()<cr>
noremap <leader>rn :call jedi#rename()<cr>

" Disable for YouCompleteMe
if has( 'python' )
  let g:jedi#completions_enabled = 0
else
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete_omni_function_list = ['python3complete#Complete']
endif

" Python Mode
let g:pymode                    = 1
let g:pymode_folding            = 0
let g:pymode_rope               = 0 " Jedi does this
let g:pymode_rope_completion    = 0
if has( 'python3' )
  let g:pymode_python           = 'python3'  " Always use python3
endif
let g:pymode_trim_whitespaces   = 0
let g:pymode_breakpoint         = 0
let g:pymode_breakpoint_bind    = '<leader>bb'
let g:pymode_lint_on_write      = 0
"let g:pymode_lint_checkers      = ['pylint', 'pep8', 'mccabe', 'pep257', 'pyflakes']
let g:pymode_lint_checkers      = ['mccabe', 'pyflakes']
let g:pymode_lint_ignore        = "F0002,W0612,C0301,C901,C0326,W0611,E221,E501,E116"
let g:pymode_lint_cwindow       = 1
let g:pymode_syntax             = 0

fun PymodeLintAll()
  let g:pymode_lint_checkers = ['pylint', 'pep8', 'mccabe', 'pep257', 'pyflakes']
  PymodeLint
  let g:pymode_lint_checkers = ['mccabe', 'pep257']
endfun
 
nmap <silent> <LocalLeader>pm :call PymodeLintAll()<cr>

" Perl
autocmd FileType perl set omnifunc=perlcomplete#Complete

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Table Mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="


" Pandoc
let g:pandoc_no_folding = 1
let g:pandoc_bibfiles = ['/Users/dacre/bib/Altitude.bib']

" NERDtree
noremap <F5> :NERDTree<CR>
let g:NERDTreeWinPos = "right"

" Sessions
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Session
nmap <leader>ss :SessionSave<CR>
nmap <leader>so :SessionOpen

" SnipMate/UltiSnpis
let g:snips_author = 'Mike Dacre'
let g:ultisnips_python_style = 'NORMAL'
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsEditSplit = "vertical"
" let g:UltiSnipsJumpForwardTrigger="<c-]>"
" let g:UltiSnipsJumpBackwardTrigger="<c-[>"

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
let tlist_python_settings = 'Python;c:classes;f:functions;m:class_members;v:variables;i:imports'

" Task List
map <leader>tl <Plug>TaskList

" Gundo
let g:gundo_prefer_python3 = 1
nnoremap <F4> :GundoToggle<CR>

" mark (special) text
let g:ex_todo_keyword = 'NOTE REF EXAMPLE SAMPLE CHECK TIPS HINT'
let g:ex_comment_lable_keyword = 'DELME TEMP MODIFY ADD KEEPME DISABLE TEST ' " for editing
let g:ex_comment_lable_keyword .= 'ERROR DEBUG CRASH DUMMY UNUSED TESTME ' " for testing
let g:ex_comment_lable_keyword .= 'FIXME BUG HACK OPTME HARDCODE REFACTORING DUPLICATE REDUNDANCY PATCH ' " for refactoring

" Comment plugin
let NERDSpaceDelims=1
let g:NERDCustomDelimiters = {
      \ 'py' : { 'left': '#' },
      \ 'sshconfig' : { 'left': '#' },
      \ 'sshdconfig': { 'left': '#' }
      \ }
map <Leader>cv <plug>NERDCommenterToggle

" Buffer Explorer
let g:bufExplorerFindActive=1
map <leader>be :BufExplorer<CR>

" R Plugin
"let g:vimrplugin_notmuxconf = 1
let g:vimrplugin_vsplit = 1
nmap <LocalLeader>ll <Plug>RSendLine

" Highlight whitespace
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()



" g:rplugin_home should be the directory where the r-plugin files are.  For
" users following the installation instructions it will be at ~/.vim or
" ~/vimfiles, that is, the same value of g:rplugin_uservimfiles. However the
" variables will have different values if the plugin is installed somewhere
" else in the runtimepath.
let g:rplugin_home = expand("<sfile>:h:h")

" g:rplugin_uservimfiles must be a writable directory. It will be g:rplugin_home
" unless it's not writable. Then it wil be ~/.vim or ~/vimfiles.
if filewritable(g:rplugin_home) == 2
    let g:rplugin_uservimfiles = g:rplugin_home
else
    let g:rplugin_uservimfiles = split(&runtimepath, ",")[0]
endif

" From changelog.vim, with bug fixed by "Si" ("i5ivem")
" Windows logins can include domain, e.g: 'DOMAIN\Username', need to remove
" the backslash from this as otherwise cause file path problems.
if executable("whoami")
    let g:rplugin_userlogin = substitute(system('whoami'), "\\", "-", "")
elseif $USER != ""
    let g:rplugin_userlogin = $USER
else
    call RWarningMsgInp("Could not determine user name.")
    let g:rplugin_failed = 1
    finish
endif

if v:shell_error
    let g:rplugin_userlogin = 'unknown'
else
    let newuline = stridx(g:rplugin_userlogin, "\n")
    if newuline != -1
        let g:rplugin_userlogin = strpart(g:rplugin_userlogin, 0, newuline)
    endif
    unlet newuline
endif

if has("win32") || has("win64")
    let g:rplugin_home = substitute(g:rplugin_home, "\\", "/", "g")
    let g:rplugin_uservimfiles = substitute(g:rplugin_uservimfiles, "\\", "/", "g")
    if $USERNAME != ""
        let g:rplugin_userlogin = substitute($USERNAME, " ", "", "g")
    endif
endif

if exists("g:vimrplugin_compldir")
    let g:rplugin_compldir = expand(g:vimrplugin_compldir)
elseif (has("win32") || has("win64")) && $AppData != "" && isdirectory($AppData)
    let g:rplugin_compldir = $AppData . "\\Vim-R-plugin"
elseif $XDG_CACHE_HOME != "" && isdirectory($XDG_CACHE_HOME)
    let g:rplugin_compldir = $XDG_CACHE_HOME . "/Vim-R-plugin"
elseif isdirectory(expand("~/.cache"))
    let g:rplugin_compldir = expand("~/.cache/Vim-R-plugin")
elseif isdirectory(expand("~/Library/Caches"))
    let g:rplugin_compldir = expand("~/Library/Caches/Vim-R-plugin")
else
    let g:rplugin_compldir = g:rplugin_uservimfiles . "/r-plugin/objlist/"
endif

" Create the directory if it doesn't exist yet
if !isdirectory(g:rplugin_compldir)
    call mkdir(g:rplugin_compldir, "p")
    if !filereadable(g:rplugin_compldir . "/README")
        let readme = ['The omnils_ and fun_ files in this directory are generated by Vim-R-plugin',
                    \ 'and vimcom and are used for omni completion and syntax highlight.',
                    \ '',
                    \ 'When you load a new version of a library, their files are replaced.',
                    \ '',
                    \ 'You should manually delete files corresponding to libraries that you no',
                    \ 'longer use.']
        call writefile(readme, g:rplugin_compldir . "/README")
    endif
endif
let $VIMR_COMPLDIR = g:rplugin_compldir


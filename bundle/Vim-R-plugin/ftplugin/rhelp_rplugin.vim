
if exists("g:disable_r_ftplugin") || has("nvim")
    finish
endif

" Source scripts common to R, Rnoweb, Rhelp and rdoc files:
runtime r-plugin/common_global.vim
if exists("g:rplugin_failed")
    finish
endif

" Some buffer variables common to R, Rnoweb, Rhelp and rdoc file need be
" defined after the global ones:
runtime r-plugin/common_buffer.vim

if !exists("b:did_ftplugin")
    if !exists("g:rplugin_runtime_warn")
        call RWarningMsgInp("Your runtime files seems to be outdated.\nSee: https://github.com/jalvesaq/R-Vim-runtime")
    endif
    let g:rplugin_runtime_warn = 1
endif

function! RhelpIsInRCode(vrb)
    let lastsec = search('^\\[a-z][a-z]*{', "bncW")
    let secname = getline(lastsec)
    if line(".") > lastsec && (secname =~ '^\\usage{' || secname =~ '^\\examples{' || secname =~ '^\\dontshow{' || secname =~ '^\\dontrun{' || secname =~ '^\\donttest{' || secname =~ '^\\testonly{')
        return 1
    else
        if a:vrb
            call RWarningMsg("Not inside an R section.")
        endif
        return 0
    endif
endfunction

let b:IsInRCode = function("RhelpIsInRCode")
let b:SourceLines = function("RSourceLines")

"==========================================================================
" Key bindings and menu items

call RCreateStartMaps()
call RCreateEditMaps()
call RCreateSendMaps()
call RControlMaps()
call RCreateMaps("nvi", '<Plug>RSetwd',        'rd', ':call RSetWD()')

" Menu R
if has("gui_running")
    runtime r-plugin/gui_running.vim
    call MakeRMenu()
endif

call RSourceOtherScripts()

if exists("b:undo_ftplugin")
    let b:undo_ftplugin .= " | unlet! b:IsInRCode b:SourceLines"
else
    let b:undo_ftplugin = " | unlet! b:IsInRCode b:SourceLines"
endif

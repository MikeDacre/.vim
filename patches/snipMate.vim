" snipMate maps
" These maps are created here in order to make sure we can reliably create maps
" after SuperTab.

let s:save_cpo = &cpo
set cpo&vim

imap sss <esc>a<Plug>snipMateNextOrTrigger
smap sss <Plug>snipMateNextOrTrigger

let &cpo = s:save_cpo

" vim:noet:

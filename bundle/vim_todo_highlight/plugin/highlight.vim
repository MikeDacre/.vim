if exists("g:loaded_whitespace") || &cp
  finish
endif
let g:loaded_whitespace = 1

" Highlight NOTE
autocmd InsertEnter * match NoteComment /[^a-zA-Z]\?NOTE[ :]\c/
autocmd BufRead,InsertLeave * match NoteComment /[^a-zA-Z]\?NOTE[ :]\c/

" Highlight TODO
autocmd InsertEnter * match TodoComment /[^a-zA-Z]\?TODO[ :]\c/
autocmd BufRead,InsertLeave * match TodoComment /[^a-zA-Z]\?TODO[ :]\c/

" Highlight trailing whitespace
autocmd FileType ruby,c,cpp,java,php,html,python,python3,perl autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd FileType ruby,c,cpp,java,php,html,python,python3,perl autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd FileType ruby,c,cpp,java,php,html,python,python3,perl autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

highlight NoteComment ctermbg=yellow ctermfg=black guibg=yellow guifg=black
autocmd ColorScheme * highlight NoteComment ctermbg=yellow ctermfg=black guibg=yellow guifg=black

highlight TodoComment ctermbg=yellow ctermfg=black guibg=yellow guifg=black
autocmd ColorScheme * highlight TodoComment ctermbg=yellow ctermfg=black guibg=yellow guifg=black

highlight LineLengthError ctermbg=234 guibg=#242424
autocmd ColorScheme * highlight LineLengthError ctermbg=234  guibg=#242424 

" Autoremove trailing spaces when saving the buffer
autocmd FileType ruby,c,cpp,java,php,html,python,python3,perl autocmd BufWritePre <buffer> :%s/\s\+$//e

" Command to clear whitespace highlighting (it can be annoying)
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>
 

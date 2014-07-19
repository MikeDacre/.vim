" vi: fdm=marker 
" Vim syntax file
" Language: Pandoc (superset of Markdown)
" Maintainer: Felipe Morales <hel.sheep@gmail.com>
" Contributor: David Sanson <dsanson@gmail.com>
" Contributor: Jorge Israel Peña <jorge.israel.p@gmail.com>
" OriginalAuthor: Jeremy Schultz <taozhyn@gmail.com>
" Version: 5.0

" Configuration: {{{1
"
" use conceal {{{2
if !exists("g:pandoc#syntax#conceal#use")
    if v:version < 703
	let g:pandoc#syntax#conceal#use = 0
    else
	let g:pandoc#syntax#conceal#use = 1
    endif
else
    " exists, but we cannot use it, disable anyway
    if v:version < 703
	let g:pandoc#syntax#conceal#use = 0
    endif
endif
"}}}2
" what groups not to use conceal in. works as a blacklist {{{2
if !exists("g:pandoc#syntax#conceal#blacklist")
    let g:pandoc#syntax#conceal#blacklist = []
endif
"}}}2
" cchars used in conceal rules {{{2
" utf-8 defaults (preferred)
if &encoding == "utf-8"
    let s:cchars = { 
		\"newline": "↵", 
		\"image": "▨", 
		\"super": "ⁿ", 
		\"sub": "ₙ", 
		\"strike": "x̶", 
		\"atx": "§",  
		\"codelang": "λ",
		\"abbrev": "→",
		\"footnote": "†",
		\"definition": " ",
		\"li": "•"}
else
    " ascii defaults
    let s:cchars = { 
		\"newline": " ", 
		\"image": "i", 
		\"super": "^", 
		\"sub": "_", 
		\"strike": "~", 
		\"atx": "#",  
		\"codelang": "l",
		\"abbrev": "a",
		\"footnote": "f",
		\"definition": " ",
		\"li": "*"}
endif
"}}}2
" if the user has a dictionary with replacements for the default cchars, use those {{{2
if exists("g:pandoc#syntax#conceal#cchar_overrides")
    let s:cchars = extend(s:cchars, g:pandoc#syntax#conceal#cchar_overrides)
endif
"}}}2
" leave specified codeblocks as Normal (i.e. 'unhighlighted') {{{2
if !exists("g:pandoc#syntax#codeblocks#ignore")
    let g:pandoc#syntax#codeblocks#ignore = []
endif
"}}}2
" use embedded highlighting for delimited codeblocks where a language is specifed. {{{2
if !exists("g:pandoc#syntax#codeblocks#embeds#use")
    let g:pandoc#syntax#codeblocks#embeds#use = 1
endif
"}}}2
" for what languages and using what vim syntax files highlight those embeds. {{{2
" defaults to None.
if !exists("g:pandoc#syntax#codeblocks#embeds#langs")
    let g:pandoc#syntax#codeblocks#embeds#langs = []
endif
"}}}2
" use italics ? {{{2
if !exists("g:pandoc#syntax#style#emphases")
    let g:pandoc#syntax#style#emphases = 1
endif
" if 0, we don't conceal the emphasis marks, otherwise there wouldn't be a way
" to tell where the styles apply.
if g:pandoc#syntax#style#emphases == 0
    call add(g:pandoc#syntax#conceal#blacklist, "block")
endif
" }}}2
" underline subscript, superscript and strikeout? {{{2
if !exists("g:pandoc#syntax#style#underline_special")
    let g:pandoc#syntax#style#underline_special = 1
endif
" }}}2
" }}}

" Functions: {{{1
" EnableEmbedsforCodeblocksWithLang {{{2
function! EnableEmbedsforCodeblocksWithLang(entry)
    try
        let s:langname = matchstr(a:entry, "^[^=]*")
        let s:langsyntaxfile = matchstr(a:entry, "[^=]*$")
        unlet! b:current_syntax
        exe 'syn include @'.toupper(s:langname).' syntax/'.s:langsyntaxfile.'.vim'
        exe "syn region pandocDelimitedCodeBlock_" . s:langname . ' start=/\(\_^\(\s\{4,}\)\=\(`\{3,}`*\|\~\{3,}\~*\)\s*\%({[^.]*\.\)\=' . s:langname . '\>.*\n\)\@<=\_^/' .
		    \' end=/\_$\n\(\(\s\{4,}\)\=\(`\{3,}`*\|\~\{3,}\~*\)\_$\n\_$\)\@=/ contained containedin=pandocDelimitedCodeBlock' .
		    \' contains=@' . toupper(s:langname)
	exe "syn region pandocDelimitedCodeBlockinBlockQuote_" . s:langname . ' start=/>\s\(`\{3,}`*\|\~\{3,}\~*\)\s*\%({[^.]*\.\)\=' . s:langname . '\>/' .
		    \ ' end=/\(`\{3,}`*\|\~\{3,}\~*\)/ contained containedin=pandocDelimitedCodeBlock' .
		    \' contains=@' . toupper(s:langname) . 
		    \",pandocDelimitedCodeBlockStart,pandocDelimitedCodeBlockEnd,pandodDelimitedCodeblockLang,pandocBlockQuoteinDelimitedCodeBlock"
    catch /E484/
      echo "No syntax file found for '" . s:langsyntaxfile . "'"
    endtry
endfunction
"}}}2
" DisableEmbedsforCodeblocksWithLang {{{2
function! DisableEmbedsforCodeblocksWithLang(langname)
    try
      exe 'syn clear pandocDelimitedCodeBlock_'.a:langname
      exe 'syn clear pandocDelimitedCodeBlockinBlockQuote_'.a:langname
    catch /E28/
      echo "No existing highlight definitions found for '" . a:langname . "'"
    endtry
endfunction
"}}}2
" WithConceal {{{2
function! s:WithConceal(rule_group, rule, conceal_rule)
    let l:rule_tail = ""
    if g:pandoc#syntax#conceal#use != 0
	if index(g:pandoc#syntax#conceal#blacklist, a:rule_group) == -1
	    let l:rule_tail = " " . a:conceal_rule
	endif
    endif
    execute a:rule . l:rule_tail
endfunction
"}}}2
"}}}1

" Commands: {{{1
command! -buffer -nargs=1 -complete=syntax PandocHighlight call EnableEmbedsforCodeblocksWithLang(<f-args>)
command! -buffer -nargs=1 -complete=syntax PandocUnhighlight call DisableEmbedsforCodeblocksWithLang(<f-args>)
" }}}

" BASE: {{{1
syntax clear
if g:pandoc#syntax#conceal#use != 0
    setlocal conceallevel=2
endif
syntax spell toplevel
"}}}

" Embeds: {{{1
" HTML: {{{2
" Set embedded HTML highlighting
syn include @HTML syntax/html.vim
syn match pandocHTML /<\/\?\a[^>]\+>/ contains=@HTML
" Support HTML multi line comments
syn region pandocHTMLComment start=/<!--/ end=/-->/
" }}}
" LaTeX: {{{2
" Set embedded LaTex (pandoc extension) highlighting
" Unset current_syntax so the 2nd include will work
unlet b:current_syntax
syn include @LATEX syntax/tex.vim
syn region pandocLaTeXInlineMath start=/\(\\\)\@<!\${\@![[:graph:]]\@=/ end=/\$/ keepend contains=@LATEX
syn region pandocLaTeXMathBlock start=/\$\$/ end=/\$\$/ keepend contains=@LATEX 
syn match pandocLaTeXCommand /\\[[:alpha:]]\+\(\({.\{-}}\)\=\(\[.\{-}\]\)\=\)*/ contains=@LATEX 
syn region pandocLaTeXRegion start=/\\begin{\z(.\{-}\)}/ end=/\\end{\z1}/ keepend contains=@LATEX
" }}}}
" }}}

" Titleblock: {{{1
"
syn region pandocTitleBlock start=/\%^%/ end=/\n\n/ contains=pandocReferenceLabel,pandocReferenceURL,pandocNewLine
call s:WithConceal("titleblock", 'syn match pandocTitleBlockMark /%\ / contained containedin=pandocTitleBlock,pandocTitleBlockTitle', 'conceal')
syn match pandocTitleBlockTitle /\%^%.*\n/ contained containedin=pandocTitleBlock
"}}}

" Blockquotes: {{{1
"
syn match pandocBlockQuote /^>.*\n\(.*\n\@1<!\n\)*/ contains=@Spell,pandocEmphasis,pandocStrong,pandocPCite,pandocSuperscript,pandocSubscript,pandocStrikeout,pandocUListItem,pandocNoFormatted skipnl

" }}}

" Code Blocks: {{{1
"
syn region pandocCodeBlockInsideIndent   start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{8,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/ contained
"}}}

" Links: {{{1
"
" Base: {{{2
syn region pandocReferenceLabel matchgroup=Operator start=/!\{,1}\[/ skip=/[\]`][\]`]\@=/ end=/\]/ keepend display
syn region pandocReferenceURL matchgroup=Operator start=/\]\@1<=(/ end=/)/ keepend display 
syn match pandocLinkTip /\s*".\{-}"/ contained containedin=pandocReferenceURL contains=@Spell display
call s:WithConceal("image", 'syn match pandocImageIcon /!\[\@=/ display', 'conceal cchar='. s:cchars["image"]) 
" }}}
" Definitions: {{{2
syn region pandocReferenceDefinition start=/\[.\{-}\]:/ end=/\(\n\s*".*"$\|$\)/ keepend
syn match pandocReferenceDefinitionLabel /\[\zs.\{-}\ze\]:/ contained containedin=pandocReferenceDefinition display
syn match pandocReferenceDefinitionAddress /:\s*\zs.*/ contained containedin=pandocReferenceDefinition
syn match pandocReferenceDefinitionTip /\s*".\{-}"/ contained containedin=pandocReferenceDefinition,pandocReferenceDefinitionAddress contains=@Spell
"}}}
" Automatic_links: {{{2
syn match pandocAutomaticLink /<\(https\{0,1}.\{-}\|.\{-}@.\{-}\..\{-}\)>/
" }}}
"}}}

" Citations: {{{1
" parenthetical citations
syn match pandocPCite /\[.\{-}-\{0,1}@.\{-}\]/ contains=pandocEmphasis,pandocStrong,pandocLatex,pandocCiteKey,@Spell display
" in-text citations with location
syn match pandocICite /@[[:graph:]äëïöüáéíóúàèìòùłßÄËÏÖÜÁÉÍÓÚÀÈÌÒÙŁß]*\s\[.\{-}\]/ contains=pandocCiteKey,@Spell display
" cite keys
syn match pandocCiteKey /-\=@[[:graph:]äëïöüáéíóúàèìòùłßÄËÏÖÜÁÉÍÓÚÀÈÌÒÙŁß]*/ containedin=pandocPCite,pandocICite contains=@NoSpell display
syn match pandocCiteAnchor /[-@]/ contained containedin=pandocCiteKey display
syn match pandocCiteLocator /[\[\]]/ contained containedin=pandocPCite,pandocICite
" }}}

" Text Styles: {{{1

" Emphasis: {{{2
"
call s:WithConceal("block", 'syn region pandocEmphasis matchgroup=Operator start=/\\\@1<!\(\_^\|\s\|[[:punct:]]\)\@<=\*\S\@=/ skip=/\(\*\*\|__\)/ end=/\*\([[:punct:]]\|\s\|\_$\)\@=/ contains=@Spell,pandocLatexInlineMath', 'concealends')
call s:WithConceal("block", 'syn region pandocEmphasis matchgroup=Operator start=/\\\@1<!\(\_^\|\s\|[[:punct:]]\)\@<=_\S\@=/ skip=/\(\*\*\|__\)/ end=/\S\@1<=_\([[:punct:]]\|\s\|\_$\)\@=/ contains=@Spell,pandocLatexInlineMath', 'concealends')
" }}}
" Strong: {{{2
"
call s:WithConceal("block", 'syn region pandocStrong matchgroup=Operator start=/\*\*/ end=/\*\*/ contains=@Spell,pandocLatexInlineMath', 'concealends')
call s:WithConceal("block", 'syn region pandocStrong matchgroup=Operator start=/__/ end=/__/ contains=@Spell,pandocLatexInlineMath', 'concealends')
"}}}
" Strong Emphasis: {{{2
"
call s:WithConceal("block", 'syn region pandocStrongEmphasis matchgroup=Operator start=/\(\*\*\*\)\S\@=/ end=/\S\@<=\*\*\*/ contains=@Spell', 'concealends')
call s:WithConceal("block", 'syn region pandocStrongEmphasis matchgroup=Operator start=/\(___\)\S\@=/ end=/\S\@<=___/ contains=@Spell', 'concealends')
" }}}
" Mixed: {{{2
call s:WithConceal("block", 'syn region pandocStrongInEmphasis matchgroup=Operator start=/\*\*/ end=/\*\*/ contained containedin=pandocEmphasis contains=@Spell', 'concealends')
call s:WithConceal("block", 'syn region pandocStrongInEmphasis matchgroup=Operator start=/__/ end=/__/ contained containedin=pandocEmphasis contains=@Spell', 'concealends')
call s:WithConceal("block", 'syn region pandocEmphasisInStrong matchgroup=Operator start=/\\\@1<!\(\_^\|\s\|[[:punct:]]\)\@<=\*\S\@=/ skip=/\(\*\*\|__\)/ end=/\S\@<=\*\([[:punct:]]\|\s\|\_$\)\@=/ contained containedin=pandocStrong contains=@Spell', 'concealends')
call s:WithConceal("block", 'syn region pandocEmphasisInStrong matchgroup=Operator start=/\\\@<!\(\_^\|\s\|[[:punct:]]\)\@<=_\S\@=/ skip=/\(\*\*\|__\)/ end=/\S\@<=_\([[:punct:]]\|\s\|\_$\)\@=/ contained containedin=pandocStrong contains=@Spell', 'concealends')

" Inline Code: {{{2

" Using single back ticks
call s:WithConceal("inlinecode", 'syn region pandocNoFormatted matchgroup=Operator start=/`/ end=/`/', 'concealends')
" Using double back ticks
call s:WithConceal("inlinecode", 'syn region pandocNoFormatted matchgroup=Operator start=/``/ end=/``/', 'concealends')
"}}}
" Subscripts: {{{2 
syn region pandocSubscript start=/\~\(\([[:graph:]]\(\\ \)\=\)\{-}\~\)\@=/ end=/\~/ keepend
call s:WithConceal("subscript", 'syn match pandocSubscriptMark /\~/ contained containedin=pandocSubscript', 'conceal cchar='.s:cchars["sub"])
"}}}
" Superscript: {{{2
syn region pandocSuperscript start=/\^\(\([[:graph:]]\(\\ \)\=\)\{-}\^\)\@=/ skip=/\\ / end=/\^/ keepend
call s:WithConceal("superscript", 'syn match pandocSuperscriptMark /\^/ contained containedin=pandocSuperscript', 'conceal cchar='.s:cchars["super"])
"}}}
" Strikeout: {{{2
syn region pandocStrikeout start=/\~\~/ end=/\~\~/ contains=@Spell keepend
call s:WithConceal("strikeout", 'syn match pandocStrikeoutMark /\~\~/ contained containedin=pandocStrikeout', 'conceal cchar='.s:cchars["strike"])
" }}}
" }}}

" Headers: {{{1
"
syn match pandocAtxHeader /^\s*#\{1,6}.*\n/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,@Spell display
syn match pandocAtxHeaderMark /\(^\s*#\{1,6}\|#*\s*$\)/ contained containedin=pandocAtxHeader
call s:WithConceal("atx", 'syn match AtxStart /#/ contained containedin=pandocAtxHeaderMark', 'conceal cchar='.s:cchars["atx"])
syn match pandocSetexHeader /^.\+\n[=]\+$/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,@Spell
syn match pandocSetexHeader /^.\+\n[-]\+$/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,@Spell
syn match pandocHeaderAttr /{.*}/ contained containedin=pandocAtxHeader,pandocSetexHeader
"}}}

" Tables: {{{1

" Simple: {{{2

syn region pandocSimpleTable start=/\(^.*[[:graph:]].*\n\)\@<!\(^.*[[:graph:]].*\n\)\(-\+\s*\)\+\n\n\@!/ end=/\n\n/ containedin=ALLBUT,pandocDelimitedCodeBlock keepend
syn match pandocSimpleTableDelims /\-/ contained containedin=pandocSimpleTable
syn match pandocSimpleTableHeader /\(^.*[[:graph:]].*\n\)\@<!\(^.*[[:graph:]].*\n\)/ contained containedin=pandocSimpleTable
hi link pandocSimpleTableDelims Delimiter
hi link pandocSimpleTableHeader pandocStrong

syn region pandocTable start=/^\(-\+\s*\)\+\n\n\@!/ end=/^\(-\+\s*\)\+\n\n/ containedin=ALLBUT,pandocDelimitedCodeBlock keepend
syn match pandocTableDelims /\-/ contained containedin=pandocTable
syn region pandocTableMultilineHeader start=/\(^-\+\n\)\@<=./ end=/\n-\@=/ contained containedin=pandocTable
hi link pandocTableMultilineHeader pandocStrong
hi link pandocTableDelims Delimiter

" }}}2
" Grid: {{{2
syn region pandocGridTable start=/\n\@1<=+-/ end=/+\n\n/ containedin=ALLBUT,pandocDelimitedCodeBlock keepend
syn match pandocGridTableDelims /[\|=]/ contained containedin=pandocGridTable
syn match pandocGridTableDelims /\([\-+][\-+=]\@=\|[\-+=]\@1<=[\-+]\)/ contained containedin=pandocGridTable
syn match pandocGridTableHeader /\(^.*\n\)\(+=.*\)\@=/ contained containedin=pandocGridTable 
hi link pandocGridTableDelims Delimiter
hi link pandocGridTableHeader Delimiter
"}}}2
" Pipe: {{{2
" with beginning and end pipes
syn region pandocPipeTable start=/\([+|]\n\)\@<!\n\@1<=|/ end=/|.*\n\n/ containedin=ALLBUT,pandocDelimitedCodeBlock keepend 
" without beginning and end pipes
syn region pandocPipeTable start=/^.*\n-.\{-}|/ end=/|.*\n\n/ keepend
syn match pandocPipeTableDelims /[\|\-:+]/ contained containedin=pandocPipeTable
syn match pandocPipeTableHeader /\(^.*\n\)\(|-\)\@=/ contained containedin=pandocPipeTable
syn match pandocPipeTableHeader /\(^.*\n\)\(-\)\@=/ contained containedin=pandocPipeTable
hi link pandocPipeTableDelims Delimiter
hi link pandocPipeTableHeader Delimiter
" }}}2
syn match pandocTableHeaderWord /\<.\{-}\>/ contained containedin=pandocGridTableHeader,pandocPipeTableHeader
hi link pandocTableHeaderWord pandocStrong
" }}}1

" Delimited Code Blocks: {{{1
" this is here because we can override strikeouts and subscripts
syn region pandocDelimitedCodeBlock start=/^\(>\s\)\?\z(\(\s\{4,}\)\=\~\{3,}\~*\)/ end=/\z1\~*/ skipnl contains=pandocDelimitedCodeBlockStart,pandocDelimitedCodeBlockEnd keepend
syn region pandocDelimitedCodeBlock start=/^\(>\s\)\?\z(\(\s\{4,}\)\=`\{3,}`*\)/ end=/\z1`*/ skipnl contains=pandocDelimitedCodeBlockStart,pandocDelimitedCodeBlockEnd keepend
call s:WithConceal("codeblock_start", 'syn match pandocDelimitedCodeBlockStart /\(\_^\n\_^\(>\s\)\?\(\s\{4,}\)\=\)\@<=\(\~\{3,}\~*\|`\{3,}`*\)/ contained containedin=pandocDelimitedCodeBlock nextgroup=pandocDelimitedCodeBlockLanguage', 'conceal cchar='.s:cchars["codelang"])
syn match pandocDelimitedCodeBlockLanguage /\(\s\?\)\@<=.\+\(\_$\)\@=/ contained 
call s:WithConceal("codeblock_delim", 'syn match pandocDelimitedCodeBlockEnd /\(`\{3,}`*\|\~\{3,}\~*\)\(\_$\n\(>\s\)\?\_$\)\@=/ contained containedin=pandocDelimitedCodeBlock', 'conceal')
syn match pandocBlockQuoteinDelimitedCodeBlock '^>' contained containedin=pandocDelimitedCodeBlock
syn match pandocCodePre /<pre>.\{-}<\/pre>/ skipnl
syn match pandocCodePre /<code>.\{-}<\/code>/ skipnl

" enable highlighting for embedded region in codeblocks if there exists a
" g:pandoc#syntax#codeblocks#embeds#langs *list*.
"
" entries in this list are the language code interpreted by pandoc,
" if this differs from the name of the vim syntax file, append =vimname
" e.g. let g:pandoc#syntax#codeblocks#embeds#langs = ["haskell", "literatehaskell=lhaskell"]
"
if g:pandoc#syntax#codeblocks#embeds#use != 0
    for l in g:pandoc#syntax#codeblocks#embeds#langs
      call EnableEmbedsforCodeblocksWithLang(l)
    endfor
endif
" }}}

" Abbreviations: {{{1
syn region pandocAbbreviationDefinition start=/^\*\[.\{-}\]:\s*/ end="$" contains=pandocNoFormatted,@Spell
call s:WithConceal('abbrev', 'syn match pandocAbbreviationSeparator /:/ contained containedin=pandocAbbreviationDefinition', "conceal cchar=".s:cchars["abbrev"])
syn match pandocAbbreviation /\*\[.\{-}\]/ contained containedin=pandocAbbreviationDefinition
call s:WithConceal('abbrev', 'syn match pandocAbbreviationHead /\*\[/ contained containedin=pandocAbbreviation', "conceal")
call s:WithConceal('abbrev', 'syn match pandocAbbreviationTail /\]/ contained containedin=pandocAbbreviation', "conceal")
" }}}

" Footnotes: {{{1
" we put these here not to interfere with superscripts.
"
syn match pandocFootnoteID /\[\^[^\]]\+\]/ nextgroup=pandocFootnoteDef
"   Inline footnotes
syn region pandocFootnoteDef start=/\^\[/ end=/\]/ contains=pandocReferenceLabel,pandocReferenceURL,pandocLatex,pandocPCite,,pandocEnDash,pandocEmDash,pandocEllipses,pandocBeginQuote,pandocEndQuote,@Spell skipnl keepend 
call s:WithConceal("footnote", 'syn match pandocFootnoteDefHead /\^\[/ contained containedin=pandocFootnoteDef', 'conceal cchar='.s:cchars["footnote"])
call s:WithConceal("footnote", 'syn match pandocFootnoteDefTail /\]/ contained containedin=pandocFootnoteDef', 'conceal')

" regular footnotes
syn region pandocFootnoteBlock start=/\[\^.\{-}\]:\s*\n*/ end=/^\n^\s\@!/ contains=pandocReferenceLabel,pandocReferenceURL,pandocLatex,pandocPCite,pandocStrong,pandocEmphasis,pandocNoFormatted,pandocSuperscript,pandocSubscript,pandocStrikeout,pandocEnDash,pandocEmDash,pandocNewLine,pandocStrongEmphasis,pandocEllipses,pandocBeginQuote,pandocEndQuote,@Spell skipnl
syn match pandocFootnoteBlockSeparator /:/ contained containedin=pandocFootnoteBlock
syn match pandocFootnoteID /\[\^.\{-}\]/ contained containedin=pandocFootnoteBlock
call s:WithConceal("footnote", 'syn match pandocFootnoteIDHead /\[\^/ contained containedin=pandocFootnoteID', 'conceal cchar='.s:cchars["footnote"])
call s:WithConceal("footnote", 'syn match pandocFootnoteIDTail /\]/ contained containedin=pandocFootnoteID', 'conceal')
" }}}

" Definitions: {{{1
"
syn region pandocDefinitionBlock start=/^\%(\_^\s*\([`~]\)\1\{2,}\)\@!.*\n\(^\s*\n\)*\s\{0,2}[:~]\(\~\{2,}\~*\)\@!/ skip=/\n\n\zs\s/ end=/\n\n/ contains=pandocDefinitionBlockMark,pandocDefinitionBlockTerm,pandocCodeBlockInsideIndent,pandocEmphasis,pandocStrong,pandocStrongEmphasis,pandocNoFormatted,pandocStrikeout,pandocSubscript,pandocSuperscript,pandocFootnoteID,pandocReferenceURL,pandocReferenceLabel,pandocAutomaticLink,pandocEmDash,pandocEnDash keepend 
syn match pandocDefinitionBlockTerm /^.*\n\(^\s*\n\)*\(\s*[:~]\)\@=/ contained contains=pandocNoFormatted,pandocEmphasis,pandocStrong
call s:WithConceal("definition", 'syn match pandocDefinitionBlockMark /^\s*[:~]/ contained', 'conceal cchar='.s:cchars["definition"])
" }}}

" List Items: {{{1
"
" Unordered lists 
syn match pandocUListItem /^>\=\s*[*+-]\s\+-\@!/he=e-1,hs=s+1 display
call s:WithConceal("list", 'syn match pandocUListItemBullet /[*+-]/ contained containedin=pandocUListItem', 'conceal cchar='.s:cchars["li"])
" Ordered lists
syn match pandocListItem /^\s*\(\((*\d\+[.)]\+\)\|\((*\l[.)]\+\)\)\s\+/he=e-1 display
syn match pandocListItem /^\s*(*\u[.)]\+\s\{2,}/he=e-1 display
syn match pandocListItem /^\s*(*[#][.)]\+\s\{1,}/he=e-1 display
syn match pandocListItem /^\s*(*@.\{-}[.)]\+\s\{1,}/he=e-1 display
" roman numerals, up to 'c', for now
syn match pandocListItem /^\s*(*x\=l\=\(i\{,3}[vx]\=\)\{,3}c\{,3}[.)]\+/ display 
" }}}

" Special: {{{1

" New_lines: {{{2
call s:WithConceal("newline", 'syn match pandocNewLine /\(  \|\\\)$/ display', 'conceal cchar='.s:cchars["newline"])
"}}}
" Ellipses: {{{2
if &encoding == "utf-8"
    call s:WithConceal("ellipses", 'syn match pandocEllipses /\.\.\./ display', 'conceal cchar=…')
endif
" }}}
" Quotes: {{{2
if &encoding == "utf-8"
    call s:WithConceal("quotes", 'syn match pandocBeginQuote /"\</  containedin=pandocEmphasis,pandocStrong display', 'conceal cchar=“')
    call s:WithConceal("quotes", 'syn match pandocEndQuote /\(\>[[:punct:]]*\)\@<="[[:blank:][:punct:]\n]\@=/  containedin=pandocEmphasis,pandocStrong display', 'conceal cchar=”')
endif
" }}}
" }}}
"
" }}}

" YAML: {{{1

try
    unlet! b:current_syntax
    syn include @YAML colors/yaml.vim
catch /E484/
endtry
syn region pandocYAMLHeader matchgroup=Delimiter start=/\%^\-\{3}\s*$/ end=/[\-|\.]\{3}\s*$/ contains=@YAML 
"}}}

" Styling: {{{1
" override this for consistency
hi pandocTitleBlock term=italic gui=italic
hi link pandocTitleBlockTitle Directory
hi link pandocAtxHeader Title
hi link AtxStart Operator
hi link pandocSetexHeader Title
hi link pandocHeaderAttr Comment

hi link pandocHTMLComment Comment
hi link pandocBlockQuote Comment

" if the user sets g:pandoc#syntax#codeblocks#ignore to contain
" a codeblock type, don't highlight it so that it remains Normal

if index(g:pandoc#syntax#codeblocks#ignore, 'definition') == -1
  hi link pandocCodeBlockInsideIndent String
endif

if index(g:pandoc#syntax#codeblocks#ignore, 'delimited') == -1
  hi link pandocDelimitedCodeBlock Special
endif

hi link pandocDelimitedCodeBlockStart Delimiter
hi link pandocDelimitedCodeBlockEnd Delimiter
hi link pandocDelimitedCodeBlockLanguage Comment
hi link pandocBlockQuoteinDelimitedCodeBlock pandocBlockQuote
hi link pandocCodePre String
hi link pandocUListItem Operator
hi link pandocListItem Operator
hi link pandocUListItemBullet Operator

hi link pandocReferenceLabel Label
hi link pandocReferenceURL Underlined
hi link pandocLinkTip Identifier
hi link pandocImageIcon Operator

hi link pandocReferenceDefinition Operator
hi link pandocReferenceDefinitionLabel Label
hi link pandocReferenceDefinitionAddress Underlined
hi link pandocReferenceDefinitionTip Identifier

hi link pandocAutomaticLink Underlined

hi link pandocDefinitionBlockTerm Identifier
hi link pandocDefinitionBlockMark Operator

hi link pandocAbbreviationHead Type
hi link pandocAbbreviation Label
hi link pandocAbbreviationTail Type
hi link pandocAbbreviationSeparator Identifier
hi link pandocAbbreviationDefinition Comment

hi link pandocFootnoteID Label
hi link pandocFootnoteIDHead Type
hi link pandocFootnoteIDTail Type
hi link pandocFootnoteDef Comment
hi link pandocFootnoteDefHead Type
hi link pandocFootnoteDefTail Type
hi link pandocFootnoteBlock Comment
hi link pandocFootnoteBlockSeparator Operator

hi link pandocPCite Normal
hi link pandocICite Normal
hi link pandocCiteKey Identifier
hi link pandocCiteAnchor Operator
hi link pandocCiteLocator Operator

if g:pandoc#syntax#style#emphases == 1
    hi pandocEmphasis gui=italic cterm=italic
    hi pandocStrong gui=bold cterm=bold
    hi pandocStrongEmphasis gui=bold,italic cterm=bold,italic
    hi pandocStrongInEmphasis gui=bold,italic cterm=bold,italic
    hi pandocEmphasisInStrong gui=bold,italic cterm=bold,italic
endif
hi link pandocNoFormatted String
hi link pandocSubscriptMark Operator
hi link pandocSuperscriptMark Operator
hi link pandocStrikeoutMark Operator
if g:pandoc#syntax#style#underline_special == 1
    hi pandocSubscript gui=underline cterm=underline
    hi pandocSuperscript gui=underline cterm=underline
    hi pandocStrikeout gui=underline cterm=underline
endif
hi link pandocNewLine Error
hi link pandocHRule Delimiter

"}}}

let b:current_syntax = "pandoc"

syntax sync clear
syntax sync minlines=100


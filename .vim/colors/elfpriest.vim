" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Henry Richardson <henry.d.richardson@gmail.com>
" Last Change:	2016 May 20
" 
" Colors
" Name/Color  HEX       16/8     TERMCOL    XTERM/HEX  L*A*B       sRGB          HSB
" ----------  -------   -----    --------   ---------- ----------  ----------    ---------
" Cyan		  #2aa198   6/6      cyan       37 #00afaf 60 -35 -05  42 161 152    175 74 63
" violet      #6c71c4   13/5     brmagenta  61 #5f5faf 50  15 -45  108 113 196 237  45  77
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "elfpriest"
hi Normal		guifg=cyan			guibg=black
hi Comment	term=bold		ctermfg=37	guifg=#268bd2
hi Constant	term=underline	ctermfg=61		guifg=Magenta
hi Special	term=bold		ctermfg=DarkMagenta	guifg=Red
hi Identifier term=underline	cterm=bold			ctermfg=Cyan guifg=#40ffff
hi Statement term=bold		ctermfg=136 gui=bold	guifg=#aa4444
hi PreProc	term=underline	ctermfg=LightBlue	guifg=#ff80ff
hi Type	term=underline		ctermfg=85	guifg=#60ff60 gui=bold
hi Function	term=bold		ctermfg=Red guifg=White
hi Repeat	term=underline	ctermfg=White		guifg=white
hi Operator				ctermfg=Red			guifg=Red
hi Ignore				ctermfg=black		guifg=bg
hi Error	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi LineNr ctermfg=DarkGrey

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special

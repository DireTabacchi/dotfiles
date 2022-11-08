" /------------------------------------------------------------------\
" Name:			Dire
" Author:		Nathaniel Tabacchi
" Maintainer:	Nathaniel Tabacchi
" Last Change:	2022 11 08
" \------------------------------------------------------------------/

" Initialization: {{{

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name="dire"

" }}}
" Palette: {{{

" setup palette dictionary
let s:dr = {}

" fill the dict with colors

" TODO: update xterm-256 colors
let s:dr.bg = ['#1d1a1a', 234]
let s:dr.fg = ['#f4dad0', 224]
" Used with bright bg text, i.e. TODO
let s:dr.contrast_fg = ['#213766', 234]

let s:dr.dark_black 	= ['#2d2a2a', 234]
let s:dr.dark_red 		= ['#932000', 88]
let s:dr.dark_green 	= ['#017b2e', 58]
let s:dr.dark_yellow	= ['#a68114', 94]
let s:dr.dark_blue		= ['#1446a0', 25]
let s:dr.dark_magenta	= ['#990278', 97]
let s:dr.dark_cyan		= ['#0f8759', 23]
let s:dr.dark_white		= ['#756964', 95]
let s:dr.dark_orange	= ['#a23f00', 130]

let s:dr.bright_black 	= ['#423838', 59]
let s:dr.bright_red 	= ['#ff3801', 160]
let s:dr.bright_green 	= ['#02c74a', 107]
let s:dr.bright_yellow	= ['#f2bd1d', 214]
let s:dr.bright_blue	= ['#1c66ed', 27]
let s:dr.bright_magenta	= ['#cc02a0', 133]
let s:dr.bright_cyan	= ['#16c783', 71]
let s:dr.bright_white	= ['#f4dad0', 224]
"let s:dr.bright_orange	= ['#f6923c', 166]
let s:dr.bright_orange	= ['#f05c00', 166]

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
let s:italic = 'italic,'
let s:underline = 'underline,'
let s:undercurl = 'undercurl,'
let s:inverse = 'inverse,'

"}}}

" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none	 = ['NONE', 'NONE']

let s:bg = s:dr.bg
let s:fg = s:dr.fg
let s:contrast_fg = s:dr.contrast_fg
let s:black 	= [ s:dr.dark_black, s:dr.bright_black ]
let s:red 		= [ s:dr.dark_red, s:dr.bright_red ]
let s:green 	= [ s:dr.dark_green, s:dr.bright_green ]
let s:yellow 	= [ s:dr.dark_yellow, s:dr.bright_yellow ]
let s:blue 		= [ s:dr.dark_blue, s:dr.bright_blue ]
let s:magenta	= [ s:dr.dark_magenta, s:dr.bright_magenta ]
let s:cyan 		= [ s:dr.dark_cyan, s:dr.bright_cyan ]
let s:white 	= [ s:dr.dark_white, s:dr.bright_white ]
let s:orange 	= [s:dr.dark_orange, s:dr.bright_orange ]

" }}}
" Highlight Function: {{{

" copied from morhetz/gruvbox
function! s:HL(group_name, fg, ...)
	" Arguments: group_name, guifg, guibg, gui, guisp
	let fg = a:fg

	" background
	if a:0 >= 1
		let bg = a:1
	else
		let bg = s:none
	endif

	" emphasis
	if a:0 >= 2 && strlen(a:2)
		let emstr = a:2
	else
		let emstr = 'NONE,'
	endif

	let histring = [ 'hi', a:group_name,
		\ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
		\ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
		\ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
		\ ]

	" special
	if a:0 >= 3
		call add(histring, 'guisp=' . a:3[0])
	endif

	execute join(histring, ' ')
endfunction


" }}}

" Begin Colorscheme -------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg, s:bg)

set background=dark

" status line of current window
call s:HL('StatusLine', s:fg, s:orange[0])
" status line of not-current window
call s:HL('StatusLineNC', s:white[1], s:black[0], s:italic)
" Screen line the Cursor is on

call s:HL('CursorLine', s:none, s:black[0])
hi! link CursorColumn CursorLine

" TODO: TabLine

" Match paired brackets under the cursor
call s:HL('MatchParen', s:contrast_fg, s:white[0], s:bold)

" Highlighted screen columns
call s:HL('ColorColumn', s:none, s:black[1])

" Concealed element
call s:HL('Conceal', s:black[0], s:none)

call s:HL('CursorLineNr', s:yellow[0], s:none)

call s:HL('NonText', s:black[1], s:none)
hi! link SpecialKey NonText

call s:HL('Visual', s:none, s:bg, s:inverse)
hi! link VisualNOS Visual

call s:HL('Search', s:yellow[1], s:black[0], s:inverse)
call s:HL('IncSearch', s:yellow[1], s:black[0], s:inverse)
call s:HL('CurSearch', s:orange[1], s:black[0], s:inverse)

call s:HL('VertSplit', s:white[0], s:black[1])

call s:HL('Directory', s:blue[0], s:none)

call s:HL('Title', s:blue[1], s:none)

call s:HL('ErrorMsg', s:black[0], s:red[1], s:bold)

call s:HL('MoreMsg', s:green[0], s:none)

call s:HL('ModeMsg', s:green[0], s:none, s:inverse . s:bold)

call s:HL('Question', s:magenta[1])

call s:HL('WarningMsg', s:red[1], s:none, s:bold . s:italic)

call s:HL('EndOfBuffer', s:green[0], s:none)

" }}}
" Gutter: {{{

call s:HL('LineNr', s:white[0], s:black[0])

call s:HL('Folded', s:blue[1], s:black[1], s:italic . s:bold)
hi! link FoldColumn Folded
hi! link SignColumn Folded

" }}}
" Cursor: {{{

" Character under curor
call s:HL('Cursor', s:none, s:none, s:inverse)
" language-mapping cursor
hi! link lCursor Cursor

"}}}
" Syntax Highlighting: {{{

" Comments
call s:HL('Comment', s:white[0], s:none)

" Generic Constants
call s:HL('Constant', s:green[1])
call s:HL('String', s:magenta[0])
call s:HL('Character', s:yellow[1])
call s:HL('Number', s:cyan[1])

" Generic Identifiers
call s:HL('Identifier', s:blue[0])
call s:HL('Function', s:orange[1], s:none, s:bold)

" Generic Statements
call s:HL('Statement', s:red[0])
call s:HL('Conditional', s:red[1])
call s:HL('Repeat', s:red[1])
call s:HL('Label', s:red[1])
call s:HL('Operator' , s:white[1])
call s:HL('Keyword', s:red[1])

" Generic Pre-processors
call s:HL('PreProc', s:magenta[1])
call s:HL('Include', s:green[0])
hi! link Define Include
call s:HL('Macro', s:orange[1])
hi! link PreCondit Include

" Generic Types
call s:HL('Type', s:cyan[0])
call s:HL('StorageClass', s:magenta[0])
call s:HL('Structure', s:blue[1])

" Generic Specials
call s:HL('Special', s:yellow[0])
call s:HL('SpecialChar', s:yellow[1])
call s:HL('Delimiter', s:orange[0])

" Other Generics
call s:HL('Underlined', s:cyan[1], s:none, s:underline)

call s:HL('Error', s:white[1], s:red[1], s:bold)

call s:HL('Todo', s:contrast_fg, s:yellow[1], s:bold)

" }}}

" Language Specific
" Haskell: {{{

call s:HL('hsDelimiter', s:orange[0])
" call s:HL('ConId', s:green[1])
" call s:HL('VarId', s:cyan[1])
call s:HL('hsVarSym', s:magenta[1])

" }}}
" Rust: {{{

call s:HL('rustIdentifier', s:green[1])
call s:HL('rustStructure', s:blue[1])
call s:HL('rustFuncCall', s:blue[0])
call s:HL('rustOperator', s:yellow[0])
"call s:HL('rustPubScope', s:orange[0])
"call s:HL('rustExternCrateString', s:yellow[0])
call s:HL('rustDerive', s:yellow[1])
"call s:HL('rustCommentBlock', s:yellow[0])
"call s:HL('rustGenericRegion', s:green[1])

" }}}

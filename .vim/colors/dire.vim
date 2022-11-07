" /------------------------------------------------------------------\
" Name:			Dire
" Author:		Nathaniel Tabacchi
" Maintainer:	Nathaniel Tabacchi
" Last Change:	2022 11 06
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
"

" Palette: {{{

" setup palette dictionary
let s:dr = {}

" fill the dict with colors

let s:dr.dark_black 	= ['#1D1A1A', 234]
let s:dr.dark_red 		= ['#7F2015', 88]
let s:dr.dark_green 	= ['#5C661E', 58]
let s:dr.dark_yellow	= ['#996F07', 94]
let s:dr.dark_blue		= ['#104277', 25]
let s:dr.dark_magenta	= ['#7C4372', 97]
let s:dr.dark_cyan		= ['#236641', 23]
let s:dr.dark_white		= ['#8E726C', 95]
let s:dr.dark_orange	= ['#AF4A1C', 130]

let s:dr.bright_black 	= ['#604E4E', 59]
let s:dr.bright_red 	= ['#D63727', 160]
let s:dr.bright_green 	= ['#919E4A', 107]
let s:dr.bright_yellow	= ['#F9AE00', 214]
let s:dr.bright_blue	= ['#2B6BB5', 27]
let s:dr.bright_magenta	= ['#B23E9D', 133]
let s:dr.bright_cyan	= ['#3AA568', 71]
let s:dr.bright_white	= ['#F4DAD0', 224]
let s:dr.bright_orange	= ['#EA6D38', 166]

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
call s:HL('Normal', s:white[1], s:black[0])

set background=dark

" status line of current window
call s:HL('StatusLine', s:white[1], s:orange[0], s:bold)
" status line of not-current window
call s:HL('StatusLineNC', s:white[1], s:black[1])
" Screen line the Cursor is on

call s:HL('CursorLine', s:none, s:black[0])
hi! link CursorColumn CursorLine

" TODO: TabLine

" Match paired brackets under the cursor
call s:HL('MatchParen', s:none, s:white[0], s:bold)

" Highlighted screen columns
call s:HL('ColorColumn', s:none, s:black[1])

" Concealed element
call s:HL('Conceal', s:green[0], s:none)

call s:HL('CursorLineNr', s:yellow[0], s:none)

call s:HL('NonText', s:black[1], s:none)
hi! link SpecialKey NonText

call s:HL('Visual', s:none, s:white[0], s:inverse)
hi! link VisualNOS Visual

call s:HL('Search', s:yellow[1], s:black[0], s:inverse)
call s:HL('IncSearch', s:yellow[1], s:black[0], s:inverse)
call s:HL('CurSearch', s:orange[1], s:black[0], s:inverse)

call s:HL('VertSplit', s:black[0], s:black[1])

call s:HL('Directory', s:blue[1], s:none)

call s:HL('Title', s:blue[0], s:none)

call s:HL('ErrorMsg', s:black[0], s:red[1], s:bold)

call s:HL('MoreMsg', s:green[0], s:none)

call s:HL('ModeMsg', s:cyan[1], s:none, s:inverse . s:bold)

call s:HL('Question', s:magenta[1])

call s:HL('WarningMsg', s:red[1], s:none, s:bold . s:italic)

" }}}
" Gutter: {{{

call s:HL('LineNr', s:yellow[1], s:none)

call s:HL('Folded', s:blue[0], s:white[0], s:italic . s:bold)
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

call s:HL('Comment', s:black[1], s:none)

call s:HL('Constant', s:green[1])
call s:HL('String', s:magenta[0])
call s:HL('Character', s:yellow[0])
call s:HL('Number', s:cyan[1])

call s:HL('Identifier', s:blue[0])
call s:HL('Function', s:orange[1], s:none, s:bold)

call s:HL('Statement', s:red[0])
call s:HL('Conditional', s:red[1])
call s:HL('Repeat', s:red[1])
call s:HL('Label', s:red[1])
call s:HL('Operator' , s:white[1])

call s:HL('PreProc', s:magenta[1])

call s:HL('Type', s:cyan[0])

call s:HL('Special', s:yellow[0])
call s:HL('Delimiter', s:orange[0])

call s:HL('Underlined', s:cyan[1], s:none, s:underline)

call s:HL('Error', s:white[1], s:red[1], s:bold)

" }}}

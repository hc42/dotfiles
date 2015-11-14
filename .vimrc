scriptencoding utf-8
set encoding=utf-8
" load plugins via pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible

" increase default history
set history=100

" colors
set background=dark
colorscheme ron
syntax on

" status bar
set laststatus=2
set ruler

" show line numbers
set number

" no bells please
set novisualbell
set noerrorbells

" highlight search results
set incsearch
set hlsearch

" directories for swp files
set backupdir=~/.vimbackup
set directory=~/.vimbackup

" use whitespaces not tabs
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set list " we do what to show tabs, to ensure we get them 
				 " out of my files
set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:% " show tabs and trailing

" autocomplete first on longest common than interate matches
set wildmode=longest:full,list:full
set wildmenu

" remove trailing spaces on file save
function TrimWhiteSpace()
	%s/\s*$//
	''
:endfunction
autocmd BufWritePre *.{c,h,cpp,ino,java,php,js} call TrimWhiteSpace()

" ardunio files with cpp code
au BufNewFile,BufRead *.ino set filetype=cpp

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" autocomplete on based on file type
filetype plugin on
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" dont wrap text
set nowrap

" enable mouse control
set selectmode=mouse
set mouse=a
" mouse type
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" shortcuts for vim tabs
map <F5> <ESC>:tabp<RETURN>
map <F6> <ESC>:tabn<RETURN>
map <F7> <ESC>:bn<RETURN>
map <F8> <ESC>:bp<RETURN>
map <C-c> <ESC>:tabnew<RETURN>
map <C-d> <ESC>:q<RETURN>
map <C-e> <ESC>:tabedit %<RETURN>
nnoremap <C-x> <C-\><C-n>:e <C-r>=fnameescape(expand('%:p:h'))<CR>

"====[ Make the 81st column stand out ]====================
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>

"=====[ Blink a red ring around the match ]=============
function! HLNext (blinktime)
	highlight RedOnRed ctermfg=red ctermbg=red
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	echo matchlen
	let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'
		\ . max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
		\ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
		\ . '\|'
		\ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1])
		\ . 'v\%<'.(col+matchlen+3).'v.'
		\ . '\|'
		\ . '\%'.(lnum+1).'l\%>'.max([col-4,1])
		\ . 'v\%<'.(col+matchlen+3).'v.'
	let ring = matchadd('RedOnRed', ring_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

" Dragvisuals plugin
runtime plugin/dragvisuals.vim
vmap	<expr>	h	 DVB_Drag('left')
vmap	<expr>	l  DVB_Drag('right')
vmap	<expr>	j	 DVB_Drag('down')
vmap	<expr>	k	 DVB_Drag('up')
vmap	<expr>	D	 DVB_Duplicate()

" Enable synatx for js libs
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1

" include folder config
set exrc
set secure

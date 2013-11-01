"MY VIM CONFIGURATION

"SET RUNTIMEPATH
set runtimepath=$HOME/.vim,$VIMRUNTIME

"if filewritable($HOME . '\\.vim\\bkp1') && !filewritable($HOME/.vim/tmp1)
	"silent execute '!mkdir ' . $HOME . '\\.vim\\bkp1'
"endif

"set dir=$HOME/.vim/tmp1,$HOME/.vim/tmp2,.
"set backupdir=$HOME/.vim/bkp1,$HOME/.vim/bkp2,.

if !exists("g:loaded_pathogen")

	let g:pathogen_disabled = []
    "call add(g:pathogen_disabled, 'neocomplcache')
    "call add(g:pathogen_disabled, 'supertab')

	runtime! autoload/pathogen.vim
	silent! call pathogen#infect()
	silent! call pathogen#helptags()
endif

"SET CONFIGURATION

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

filetype plugin on
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set hidden       " allow switching buffers, which have unsaved changes

set autoread
set cindent
set guioptions-=Tr
"set guioptions-=TrLb
set history=200 " keep 200 lines of command line history
set mouse=a     " use mouse in xterm to scroll
set mousehide
set nobackup    " DON'T keep a backup file
set nospell
set number      " line numbers

set autoindent
set ruler       " show the cursor position all the time
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab " default settings

set scrolloff=5  " 5 lines before and after the current line when scrolling
set showcmd      " display incomplete commands

"serach Options
set hlsearch
set incsearch    " do incremental searching
set showmatch    " showmatch: Show the matching bracket for the last ')'?
set ignorecase   " ignore case
set smartcase    " but don't ignore it, when search string contains uppercase letters
"set spelllang=pt_br

set wrap				"nowrap by default
"
"set textwidth=80
"set formatoptions+=a
set linebreak
set nolist

set wildmenu
syntax enable
set completeopt=menu,longest,preview
set confirm

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"GENERAL KEYMAPPING

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Remapping leader key
let mapleader=","

nmap <leader>hl :call HlSearchtoggle()<CR>
nmap <leader>ts :call TabSizeToggle()<CR>

" Check spell
"nmap <silent> <leader>s :set spell!<CR>

" Open vimrc
nmap <silent> <leader>ov :tabnew<CR>:e ~/.vim/.vimrc<CR>
"autocmd BufWritePost .vimrc :!start cp -f ~/.vim/.vimrc ~/_vimrc
nmap <silent> <leader>sv :w<CR>:!start powershell cp ~/.vim/.vimrc ~/_vimrc<CR>

" Toggle line numbers between relative and absolute
map <leader>nt :call NumberToggle()<CR>

" Tab mappings.
noremap <leader>tt :tabnew<cr>
noremap nt :tabnext<CR>
noremap pt :tabprevious<CR>
noremap te :tabedit
noremap tf :tabfirst<cr>
noremap tl :tablast<cr>
noremap tm :tabmove<cr>

"Window resizing
map <A-+> <C-w>+
map <A-_> <C-w>-
map <A->> <C-w>>
map <A-<> <C-w><

"auto complete brackets, parenteses and so on
imap ( ()<left>
imap "<space> ""<left>
imap '<space> ''<left>
imap { {}<left>
imap [ []<left>

"automatically change current working directory
map <leader>cwd :lcd %:p:h<CR>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap <c-w><c-q> <Nop>
noremap <c-w>q <Nop>

" Remap VIM 0 to first non-blank character and ^ to first character
noremap 0 ^
noremap ^ 0

"Remap r to R
nnoremap r R
nnoremap R r

"Indenting on visual mode
vmap > >gv
vmap < <gv

" Copy from cursor to the end of the line
nnoremap Y y$
nnoremap <C-Y> "+y$

nnoremap <C-Up> :call SavePosition(".")<CR>:.m.-2<CR>:call LoadPosition()<CR>
nnoremap <C-Down> :call SavePosition(".")<CR>:.m.+1<CR>:call LoadPosition()<CR>

nnoremap <S-Up> :call SavePosition(".-1")<CR>:.t.-1<CR>:call LoadPosition()<CR>
nnoremap <S-Down> :call SavePosition(".+1")<CR>:.t.<CR>:call LoadPosition()<CR>

function! SavePosition(line)
	let g:savedCursorPosition = col(".")
	let g:savedLinePosition = line(a:line)
endfunction

function! LoadPosition()
	call setpos(".", [0, g:savedLinePosition, g:savedCursorPosition, 0])
endfunction

function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction

" Thanks to Andrew Ray by the gist: https://gist.github.com/DelvarWorld/048616a2e3f5d1b5a9ad
" Locally (local to block) rename a variable
nmap <Leader>rf "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[{V%:s/<C-R>//<c-r>z/g<cr>`x

"CamelCasePlugin key mapping
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b

sunmap w
sunmap b

" Fake '|' as text object
nnoremap di\| T\|d,
nnoremap da\| F\|d,
nnoremap ci\| T\|c,
nnoremap ca\| F\|c,
nnoremap yi\| T\|y,
nnoremap ya\| F\|y,
nnoremap vi\| T\|v,
nnoremap va\| F\|v,

" Fake '/' as text object
nnoremap di/ T/d,
nnoremap da/ F/d,
nnoremap ci/ T/c,
nnoremap ca/ F/c,
nnoremap yi/ T/y,
nnoremap ya/ F/y,
nnoremap vi/ T/v,
nnoremap va/ F/v,

"Filename, filpath and like
if has('win32') || has('win64')
  nmap <silent><leader>pfn <C-R>=expand("%:t:r")<CR>
  nmap <silent><leader>cfn :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
  nmap <silent><leader>cfp :let @*=substitute(expand("%:p:h"), "/", "\\", "g")<CR>
  nmap <silent><leader>oe :!start explorer "%:p:h"<CR>
  nmap <silent><leader>os :!start powershell -NoExit cd "%:p:h"<CR>
else
  nmap <silent><leader>cfn :let @*=expand("%:p")<CR>
  nmap <silent><leader>cfp :let @*=expand("%:p:h")<CR>
  nmap <silent><leader>oe <leader>cfp :!nautilus<C-R>*<CR>
  nmap <silent><leader>os <leader>cfp :!terminal cd <C-R>*<CR>
endif

"put current time and day on file
nnoremap <F5> "=strftime("%x %X")<CR>P
inoremap <F5> <C-R>=strftime("%x %X")<CR>

map <silent><F7> :!start ctags.exe --append=no --recurse=yes -f ./tags --extra=+fq --fields=+fiKlmnsSzt --c\#-kinds=cdefimnps --sort=yes ./* <CR>:set tags=tags<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"PLUGINS

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Matchit
"~~~~~~~~
runtime! macros/matchit.vim

"NeoComplCache
"~~~~~~~~

" Enable NeoComplCache on startup
let g:neocomplcache_enable_at_startup = 1

"NERDTree
"~~~~~~~~
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore = ['.*\.meta', '.*\.\(cs\|unity\)proj','.*\.pidb']

map <f2> :NERDTreeToggle<cr>
map <C-f2> :NERDTree ~/<CR>

autocmd vimenter * if !argc() | NERDTree ~/ | endif

"Sparkup
let g:sparkup = "~/.vim/bundle/sparkup/"

"Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"FONTS AND COLORSCHEME

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
colorscheme solarized

if has('gui_running')
  set guifont=Consolas:h11
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~

"MY FUNCTIONS

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

function! HlSearchtoggle()
  if(&hlsearch == 1)
    set nohlsearch
  else
    set hlsearch
  endif
endfunc

function! TabSizeToggle()
	if(&tabstop == 4)
		set tabstop=2 shiftwidth=2 softtabstop=2
	else
		set tabstop=4 shiftwidth=4 softtabstop=4
	endif
	echo "tab size:" &tabstop
endfunc

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" remove whitespaces function
function! <SID>RemoveWhitespaces()
  let l = line(".")
  let c = col(".")
  execute '%s/\s\+$//e'
  call cursor(l, c)
endfunction

let g:CopyResultToClipboard=1
let g:CopyResultToClipboardAlternative=1

function! <SID>DoCalc()
	let line = getline('.')
	if(exists("g:CopyResultToClipboard"))
		let @+=eval(line)
	else
		if(exists("g:CopyResultToClipboardAlternative")
			let @a=eval(line)
		endif
	endif
	echo eval(line)
endfunction

map <Leader>u :call SearchUnity()<CR>
function! SearchUnity()
	exec 'normal viw"0y'
	let line = @0
	let line = "C:/Program Files (x86)/Unity/Editor/Data/Documentation/Documentation/ScriptReference?q=" . line
	exec "start iexplore ".line
endfunction

" By Tim Pope
function! OpenURL(url)
  if has("win32")
    exe "!start cmd /cstart /b ".a:url.""
  elseif $DISPLAY !~ '^\w'
    exe "silent !sensible-browser \"".a:url."\""
  else
    exe "silent !sensible-browser -T \"".a:url."\""
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)

" mapping to open URL under cursor
nnoremap <leader>gf :OpenURL <cfile><CR>
nnoremap <leader>ga :OpenURL http://www.answers.com/<cword><CR>
nnoremap <leader>gg :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap <leader>gu :OpenURL http://docs.unity3d.com/Documentation/ScriptReference/30_search.html?q=<cword><CR>
nnoremap <leader>gw :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
nnoremap <leader>gt :OpenURL http://translate.google.com/\#en/pt/<cword><CR>

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"
"endfunction
"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"MISCELANIA

" automatically remove whitespaces before saving buffer
autocmd BufWritePre * :call <SID>RemoveWhitespaces()

"C# syntax

au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}
au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs set foldlevelstart=2
au FileType cs set errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m

"HTML
au FileType html set foldmethod=indent
au FileType html set foldlevelstart=1

"CSS
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}

"Javascript
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

" Tags
set tags=tags

" Taglist plugin
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window=1
let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_File_Fold_Auto_Close=1

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" omnicppcomplete options
map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f <CR><CR>
" ~/.vim/commontags /usr/include /usr/local/include ~/moz/obj-ff-dbg/dist/include<CR><CR>
set tags+=~/.vim/tags/commontags

" --- OmniCppComplete ---
" auto close options when exiting insert mode or moving away
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces

" -- ctags --
" add current directory's generated tags file to available tags
set tags+=./tags

" Remember info about open buffers on close
set viminfo^=%

" Execute 'cmd' while redirecting output.
" Delete all lines that do not match regex 'filter' (if not empty).
" Delete any blank lines.
" Delete '<whitespace><number>:<whitespace>' from start of each line.
" Display result in a scratch buffer.
function! s:Filter_lines(cmd, filter)
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines
  g/^\s*$/d
  %s/^\s*\d\+:\s*//e
  if !empty(a:filter)
    execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)

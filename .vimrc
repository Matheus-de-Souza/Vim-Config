"MY VIM CONFIGURATION

"SET RUNTIMEPATH
set runtimepath=$HOME/.vim,$VIMRUNTIME

if !exists("g:loaded_pathogen")
	"runtime! autoload/pathogen.vim
	silent! call pathogen#helptags()
	silent! call pathogen#runtime_append_all_bundles()
endif

"SET CONFIGURATION

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

filetype plugin on
set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		" DON'T keep a backup file

set history=200		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set ts=4 sts=4 sw=4 noexpandtab " default settings

set autoread
set number				" line numbers
set autoindent
set cindent
set encoding=utf-8
set mouse=a				" use mouse in xterm to scroll
set scrolloff=5 		" 5 lines before and after the current line when scrolling
set ignorecase			" ignore case
set smartcase			" but don't ignore it, when search string contains uppercase letters
set hidden 				" allow switching buffers, which have unsaved changes
set mousehide
set shiftwidth=4		" 4 characters for indenting
set showmatch			" showmatch: Show the matching bracket for the last ')'?
set scrolloff=3 		" minimum lines to keep above and below cursor
set nospell
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

" Remapping leader key
let mapleader=","

map <leader>ow <ESC>:NERDTree C:/Program Files\ \(x86\)/EasyPHP-5.3.8.1/www/<CR>

nmap <leader>hl :call HlSearchtoggle()<CR>
nmap <leader>ts :call TabSizeToggle()<CR>

" Check spell
nmap <silent> <leader>s :set spell!<CR>

" Open vimrc
nmap <silent> <C-f12> <ESC>:tabnew<CR>:e ~/.vim/.vimrc<CR>

" Toggle line numbers between relative and absolute
nmap <silent> <leader>nt :call NumberToggle()<CR>

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove<cr>

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

" Remap VIM 0 to first non-blank character
map 0 ^

"Remap r to R
nnoremap r R

"Indenting on visual mode
vmap > >gv
vmap < <gv

" Copy from cursor to the end of the line
nnoremap Y y$

"CamelCasePlugin key mapping
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b

sunmap w
sunmap b

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

map <silent><F7> :!start C:/Users/Matheus/.vim/tags/ctags.exe --append=yes --recurse=yes -f C:/Users/Matheus/.vim/tags/commontags --extra=+fq --fields=+fiKlmnsSzt --c\#-kinds=cdefimnps --sort=yes C:/Users/Matheus/Documents/Repositorios/Catalogo/*<CR>

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
"
"NERDTree
"~~~~~~~~
map <f2> :NERDTreeToggle<cr>
imap <f2> <esc>:NERDTreeToggle<cr>a

if has('win32') || has('win64')
	autocmd vimenter * if !argc() | NERDTree C:/USERS/Matheus/Documents/Repositorios/ | endif
endif

let NERDTreeIgnore=['.*\.meta', '.*\.\(cs\|unity\)proj','.*\.pidb']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"FONTS AND COLORSCHEME

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has('gui_running')
  set guifont=Consolas:h11
  colorscheme solarized
else
  colorscheme slate
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
	echo "tab size: " &tabstop
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
au FileType html set foldlevelstart=5

"CSS
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}

"Javascript
au FileType Javascript set foldmethod=marker
au FileType Javascript set foldmarker={,}

" Tags
set tag=C:/USERS/Matheus/.vim/tags/commontags

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
set tags+=C:/USERS/Matheus/.vim/tags/commontags

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

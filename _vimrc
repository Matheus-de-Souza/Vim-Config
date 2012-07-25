"MY VIM CONFIGURATION

"SET RUNTIMEPATH
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIMRUNTIME
endif

runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

"SET CONFIGURATION

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

filetype plugin on
set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		" DON'T keep a backup file

set history=50		" keep 50 lines of command line history
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
set wrap				"nowrap by default
set wildmenu
syntax enable
set completeopt=menu,longest,preview
set confirm

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"GENERAL KEYMAPPING

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Remapping leader key
let mapleader=","

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q

nmap ,hl :call HlSearchtoggle()<CR>

" Open vimrc
if has('win32') || has('win64')
	nmap <C-f12> <ESC>:tabnew<CR>:e ~/_vimrc<CR>
else
	nmap <C-f12> <ESC>:tabnew<CR>:e ~/vimrc<CR>
endif

"ctrl + space @_@
imap <C-space> <C-n>
map <C-S-N> :call NumberToggle()<CR>

"tabs
map <C-S-T> <ESC>:tabnew<CR>:NERDTreeMirror<CR>
map <C-S-L> <ESC>:tabnext<cr>
map <C-S-H> <ESC>:tabprevious<cr>
map <C-S-C> <ESC>:tabclose<cr>

imap ( ()<left>
imap "<space> ""<left>
imap '<space> ''<left>
imap { {}<left>
imap [ []<left>

" Remap VIM 0 to first non-blank character
map 0 ^

"CamelCasePlugin key mapping
map <silent>w <Plug>CamelCaseMotion_w
map <silent>b <Plug>CamelCaseMotion_b

sunmap w
sunmap b

map <silent><S-W> <S-right>
map <silent><S-B> <S-left>

"Filename, filpath and like:w
if has('win32')
  inoremap <silent><leader>pfn <C-R>=expand("%:t:r")<CR>
  nmap <silent><leader>cfn :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
  nmap <silent><leader>cfp :let @*=substitute(expand("%:p:h"), "/", "\\", "g")<CR>
  nmap <silent><leader>oe <leader>cfp :!start explorer "<C-R>*"<CR>
  nmap <silent><leader>os <leader>cfp :!start powershell -NoExit cd "<C-R>*"<CR>
else
  nmap <silent><leader>cfn :let @*=expand("%:p")<CR>
  nmap <silent><leader>cfp :let @*=expand("%:p:h")<CR>
  nmap <silent><leader>oe <leader>cfp :!nautilus<C-R>*<CR>
  nmap <silent><leader>os <leader>cfp :!terminal cd <C-R>*<CR>
endif

nmap <leader>ddl :g/^$/d<CR>
map <silent><F7> :!start C:/Users/Matheus/.vim/tags/ctags.exe --recurse=yes -f C:/Users/Matheus/.vim/tags/commontags --exclude="bin" --fields=+ianmzS --c\#-kinds=cimnp C:/Users/Matheus/Documents/Repositorios/Catalogo<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"PLUGINS

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Pathogen
call pathogen#helptags()
call pathogen#infect()

"NERDTree
"~~~~~~~~
map <f2> :NERDTreeToggle<cr>
imap <f2> <esc>:NERDTreeToggle<cr>a

autocmd vimenter * if !argc() | NERDTree C:/USERS/Matheus/Documents/Repositorios/ | endif

let NERDTreeIgnore=['.*\.meta', '.*\.unity.+', '.*\.\(cs\|unity\)proj','.*\.pidb']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~

"FONTS AND COLORSCHEME

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
if has('gui_running')
  set guifont=Envy_Code_R:h10
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
nnoremap TT :TlistToggle<CR>
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

" imap jj			<Esc>

" omnicppcomplete options
map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f <CR><CR>
" ~/.vim/commontags /usr/include /usr/local/include ~/moz/obj-ff-dbg/dist/include<CR><CR>
set tags+=C:/USERS/Matheus/.vim/tags/commontags

" --- OmniCppComplete ---
" -- required --
set nocp " non vi compatible mode
filetype plugin on " enable plugins

" -- optional --
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
" map <ctrl>+F12 to generate ctags for current folder:
map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags

" Remember info about open buffers on close
set viminfo^=%

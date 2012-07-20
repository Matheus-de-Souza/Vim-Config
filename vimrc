"MY VIM CONFIGURATION

"SET RUNTIMEPATH
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
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
set tabstop=4

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
nmap <C-f12> <ESC>:tabnew<CR>:e $VIM/vimrc<CR>

"ctrl + space @_@
imap <C-space> <C-n>
map <C-S-N> :call NumberToggle()<CR>

"windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
  inoremap <silent><leader>pf <C-R>=expand("%:t:r")<CR>
  nmap <silent><leader>cf :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
  nmap <silent><leader>cp :let @*=substitute(expand("%:p:h"), "/", "\\", "g")<CR>
  nmap <silent><leader>coe <leader>cp :!start explorer "<C-R>*"<CR>
  nmap <silent><leader>cos <leader>cp :!start powershell -NoExit cd "<C-R>*"<CR>
else
  nmap <silent><leader>cf :let @*=expand("%:p")<CR>
  nmap <silent><leader>cp :let @*=expand("%:p:h")<CR>
  nmap <silent><leader>coe <leader>cp :!nautilus<C-R>*<CR>
  nmap <silent><leader>cos <leader>cp :!terminal cd <C-R>*<CR>
endif

map <silent><F7> :!start ctags.exe --recurse=yes -f C:/Users/Matheus/Documents/Repositorios/Catalogo/tagfile --exclude="bin" --fields=+ianmzS --c\#-kinds=cimnp C:/Users/Matheus/Documents/Repositorios/Catalogo<CR>

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

autocmd vimenter * if !argc() | NERDTree c:/USERS/Matheus/Documents/Repositorios/ | endif

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

set tag=C:\Users\Matheus\Documents\Repositorios\Catalogo\tagfile

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

" Remember info about open buffers on close
set viminfo^=%

" *****************************************************************************
"
" Tim's ever growing vimrc, will get to commenting the specifics at some later
" stage... Optimised for a Dvorak layout, apoklinon colours and xmonad.
"
" *****************************************************************************

set nocompatible
execute pathogen#infect() 

" Tabs ************************************************************************
"set sta " a <Tab> in an indent inserts 'shiftwidth' spaces

function! Tabstyle_tabs()
  " Using 4 column tabs
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
  autocmd User Rails set softtabstop=4
  autocmd User Rails set shiftwidth=4
  autocmd User Rails set tabstop=4
  autocmd User Rails set noexpandtab
endfunction

function! Tabstyle_spaces(num)
    let &l:softtabstop=a:num
    let &l:shiftwidth=a:num
    let &l:tabstop=a:num
    set expandtab
endfunction

call Tabstyle_spaces(4)

augroup filetypedetect
au BufNewFile,BufRead *.asy     setf asy
augroup END
filetype plugin on

" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)

" Shows Syntax highlight stack under cursor. Useful for debugging colorschemes
map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4


" Title  **********************************************************************
let &titleold = getcwd()
set title
auto BufEnter * let &titlestring = s:MyTitle()

if &term =~ 'screen\(\.\(xterm\|rxvt\)\(-\(256\)\?color\)\?\)\?'
  " Set the screen title using the vim "iconstring"."
  set t_IS=^[k
  set t_IE=^[\
  set icon
  auto BufEnter * let &iconstring = &titlestring
  " Set the xterm title using the vim "titlestring"."
  set t_ts=^[]2;
  set t_fs=^G
endif

" Perform zsh-like prompt expansion using the template {prompt}.  See
" "EXPANSION OF PROMPT SEQUENCES" in zshmisc(1).
function s:ZshPromptExpn(prompt)
  if &shell == "/bin/zsh"
    return system("print -Pn " . shellescape(a:prompt))
  else
    " Fallback to poor man's prompt expansion.
    " By no means equivalent to zsh.
    let idx = 0
    let result = ''
    let escapere = '%\([%)m]\|\(\(-\?[0-9]\+\)\?[~]\)\)'
    while idx < len(a:prompt)
      let nextesc = match(a:prompt, escapere, idx)
      if nextesc < 0
        let result .= a:prompt[idx :]
        break
      elseif idx < nextesc
        let result .= a:prompt[idx : (nextesc - 1)]
      endif

      let idx = matchend(a:prompt, escapere, nextesc)
      let esc = a:prompt[nextesc : (idx - 1)]
      if esc == '%m'
        let result .= substitute(hostname(), '^\([^.]*\).*', '\1', '')
      elseif esc =~ '%-\?[0-9]*[~]'
        let result .= fnamemodify(getcwd(), ':~')[:-1]
      elseif esc == '%%'
        let result .= '%'
      endif
    endwhile
    return result
endfunction

function s:MyTitle()
  return s:ZshPromptExpn("%m:%-3~ ") .
  \ v:progname . " " . fnamemodify(expand("%:f"), ":.")
endfunction


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" Vertical and horizontal split then hop to a new buffer
:noremap <Leader>v :vsp^M^W^W<cr>
:noremap <Leader>h :split^M^W^W<cr>

nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Cursor highlights ***********************************************************
"set cursorline
"set cursorcolumn


" Searching *******************************************************************
set hlsearch  " highlight search
set incsearch  " Incremental search, search as you type

" Colors **********************************************************************
set t_Co=256 " 256 colors
set background=dark 
syntax on " syntax highlighting
let g:apoklinon_use_Xresources = $apoklinonRGB
colorscheme apoklinon

autocmd! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high
"match LongLineWarning '\%120v.*' " Error format when a line is longer than 120


" Line Wrapping ***************************************************************
set nowrap
set linebreak  " Wrap at word


" Directories *****************************************************************
" Setup backup location and enable
"set backupdir=~/backup/vim
"set backup

" Set Swap directory
"set directory=~/backup/vim/swap

" Sets path to directory buffer was loaded from
"autocmd BufEnter * lcd %:p:h


" File Stuff ******************************************************************
filetype plugin indent on
" To show current filetype use: set filetype

" Latex Stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='zathura'
"autocmd FileType html :set filetype=xhtml


" Insert New Line *************************************************************
map <S-Enter> O<ESC> " inserts new line without going into insert mode
map <Enter> o<ESC>
"set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)


" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap <Leader>i :set list!<CR> " Toggle invisible chars


" Mouse ***********************************************************************
"set mouse=a " Enable the mouse
"behave xterm
"set selectmode=mouse

" Keyboard  *******************************************************************
function Keyboard(type)
   if a:type == "dvorak"
      call UnmapWorkman()
      noremap d h
      noremap h j
      noremap t k
      noremap n l
      noremap s :
      noremap S :
      noremap j d
      noremap l n
      noremap L N

      noremap - $
      noremap _ ^
      noremap N <C-w><C-w>
      noremap H 8<Down>
      noremap T 8<Up>
      noremap D <C-w><C-r>
   elseif a:type == "workman"
      call UnmapDvorak()
      "(O)pen line -> (L)ine
      noremap l o
      noremap o l
      noremap L O
      noremap O L
      "Search (N)ext -> (J)ump
      noremap j n
      noremap n j
      noremap J N
      noremap N J
      "(E)nd of word -> brea(K) of word
      noremap k e
      noremap e k
      noremap K E
      noremap E <nop>
      noremap h y
      "(Y)ank -> (H)aul
      noremap y h
      noremap H Y
      noremap Y H
   else " qwerty
      call UnmapDvorak()
      call UnmapWorkman()
   endif
endfunction

function UnmapDvorak()
    "Unmaps Dvorak keys
      silent! unmap d
      silent! unmap h
      silent! unmap t
      silent! unmap n
      silent! unmap s
      silent! unmap S
      silent! unmap j
      silent! unmap l
      silent! unmap L
 
      silent! unmap -
      silent! unmap _
      silent! unmap N
      silent! unmap H
      silent! unmap T
      silent! unmap D
endfunction

function UnmapWorkman()
    "Unmaps Workman keys
    silent! unmap h
    silent! unmap j
    silent! unmap k
    silent! unmap l
    silent! unmap y
    silent! unmap n
    silent! unmap e
    silent! unmap o
    silent! unmap H
    silent! unmap J
    silent! unmap K
    silent! unmap L
    silent! unmap Y
    silent! unmap N
    silent! unmap E
    silent! unmap O
endfunction

function LoadKeyboard()
   let keys = $keyboard
   if (keys == "workman")
       call Keyboard("workman")
   elseif (keys == "qwerty")
       call Keyboard("qwerty")
   else
       call Keyboard("dvorak")
   endif
endfunction

autocmd VimEnter * call LoadKeyboard()

:noremap <Leader>q :call Keyboard("qwerty")<CR>:echom "Qwerty Keyboard Layout"<CR>
:noremap <Leader>d :call Keyboard("dvorak")<CR>:echom "Dvorak Keyboard Layout"<CR>
:noremap <Leader>w :call Keyboard("workman")<CR>:echom "Workman Keyboard Layout"<CR>

" Misc settings ***************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how
set nofoldenable " Turn off folding 
map <Leader>l :set invnumber<CR> " Toggle line numbers 
set pastetoggle=<F10>
" Navigation ******************************************************************

" Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge

map <Leader>p <C-^> " Go to previous file

cmap w!! %!sudo tee > /dev/null %

" Omni Completion *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" May require ruby compiled in
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete 

" This probably needs a section but it's here for now
"au BufEnter *.hs compiler ghc
" How many lines should be searched for context
let g:hasksyn_indent_search_backward = 100

" Should we try to de-indent after a return
let g:hasksyn_dedent_after_return = 1

" Should we try to de-indent after a catchall case in a case .. of
let g:hasksyn_dedent_after_catchall_case = 1

" -----------------------------------------------------------------------------  
" |                              Plug-ins                                     |
" -----------------------------------------------------------------------------  

" NERDTree ********************************************************************
:noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything


" NERD Commenter **************************************************************
let NERDCreateDefaultMappings=0 " I turn this off to make it simple

" Toggle commenting on 1 line or all selected lines. Wether to comment or not
" is decided based on the first line; if it's not commented then all lines
" will be commented
:map <Leader>c :call NERDComment(0, "toggle")<CR> 


" SnippetsEmu *****************************************************************
"imap <unique> <C-j> <Plug>Jumper
"let g:snip_start_tag = "_\."
"let g:snip_end_tag = "\._"
"let g:snip_elem_delim = ":"
"let g:snip_set_textmate_cp = '1'  " Tab to expand snippets, not automatically.


" CommandT ********************************************************
  " To compile:
  " cd ~/cl/etc/vim/ruby/command-t
  " ruby extconf.rb
  " make
let g:CommandTMatchWindowAtTop = 1
map <Leader>f :CommandT<CR>


" fuzzyfinder ********************************************************
" I'm using CommandT for main searching, but it doesn't do buffers, so I'm
" using FuzzyFinder for that
map <Leader>b :FufBuffer<CR>
"let g:fuzzy_ignore = '.o;.obj;.bak;.exe;.pyc;.pyo;.DS_Store;.db'


" autocomplpop ***************************************************************
" complete option
"set complete=.,w,b,u,t,k
"let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k'
"set complete=.
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_BehaviorKeywordLength = 2


" railsvim ***************************************************************
map <Leader>ra :AS<CR>
map <Leader>rs :RS<CR>

" -----------------------------------------------------------------------------  
" |                               Startup                                     |
" -----------------------------------------------------------------------------  
" Open NERDTree on start
"autocmd VimEnter * exe 'NERDTree' | wincmd l 

" -----------------------------------------------------------------------------  
" |                               Host specific                               |
" -----------------------------------------------------------------------------  

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif


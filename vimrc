set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'antiAgainst/cscope-macros.vim'        " Brings in the ctrl-\ <g|s|c> shortcuts
Plugin 'tpope/vim-repeat'                     " pre-requisite for easyclip
Plugin 'tpope/vim-fugitive'                   " The awesome git plugin. Period.
Plugin 'tpope/tpope-vim-abolish'              " substitute rightly. :Abolish, :Subvert, crm/crs
Plugin 'jreybert/vimagit'                     " :Magit command
Plugin 'scrooloose/nerdtree'                  " Directory browser
Plugin 'Xuyuanp/nerdtree-git-plugin'          " Show gittish info when nerd-tree is invoked
Plugin 'justinmk/vim-sneak'                   " goto any location using s<char>
Plugin 'jiangmiao/auto-pairs'                 " for automatically adding braces
Plugin 'tmhedberg/matchit'                    " % given a new life
Plugin 'easymotion/vim-easymotion'            " <Leader>hjkl
Plugin 'vim-scripts/ingo-library'             " Prerequisite for PatternComplete
Plugin 'vim-scripts/CompleteHelper'           " Prerequisite for PatternComplete
Plugin 'vim-scripts/PatternComplete'          " ctrl-r+& to paste the matched word instead of pattern
Plugin 'vim-scripts/python_match.vim'         " % for if/elif/else, try/except/catch in py. Also use [% to go to start of block 
Plugin 'vim-airline/vim-airline'              " look and feel with powerline-ish fonts
Plugin 'vim-airline/vim-airline-themes'       " More themese for airline
Plugin 'majutsushi/tagbar'                    " Enables the c-function names with g:airline#extensions#tagbar#enabled below.
Plugin 'vim-scripts/AnsiEsc.vim'              " To view files having ansi-esc chars.
Plugin 'airblade/vim-gitgutter'               " Puts up a line(gutter) in the left column with git-ish information
Plugin 'scrooloose/nerdcommenter'             " Comment/remove-comment blocks quickly
Plugin 'junegunn/fzf.vim'                     " :Fzf and other commands
Plugin 'altercation/vim-colors-solarized'     " Solarized vim
Plugin 'regedarek/ZoomWin'                    " Close other windows and re-open them again
Plugin 'yssl/QFEnter'                         " <Leader><CR> on quickfix/loc-list will open in a new vert split.
Plugin 'fatih/vim-go'                         " One stop go plugin
Plugin 'godlygeek/tabular'                    " Auto-align lines.
Plugin 'plasticboy/vim-markdown'              " Markdown syntax
Plugin 'tpope/vim-surround'                   " add quotes(surroundings) to a word etc..
Plugin 'jeetsukumaran/vim-indentwise'         " help navigating blocks based on indent.
Plugin 'vim-scripts/Mark--Karkat'             " Multiple color search
Plugin 'tpope/vim-speeddating'                " Pre-req for vim-orgmode
Plugin 'jceb/vim-orgmode'                     " Org style
Plugin 'guns/xterm-color-table.vim'           " :XtermColorTable -- help to know color numbers
Plugin 'sk1418/QFGrep'                        " Filter entries in quickfix
Plugin 'mtth/scratch.vim'                     " Open up a scratch buffer
if has('nvim')
  Plugin 'Shougo/denite.nvim'                 " :Denite
else
  Plugin 'Shougo/vimproc.vim'                 " Needed for unite
  Plugin 'Shougo/unite.vim'                   " :Unite
endif
Plugin 'Shougo/neomru.vim'                    " :for file_mru option in Unite
Plugin 'Shougo/neoyank.vim'                   " :Unite history/yank
Plugin 'kana/vim-textobj-user'                " pre-req for indent/line
Plugin 'kana/vim-textobj-indent'              " indent text-object
Plugin 'kana/vim-textobj-line'                " line text-object
Plugin 'kana/vim-textobj-lastpat'             " last search text-object
Plugin 'bps/vim-textobj-python'               " python function/class selector
Plugin 'thinca/vim-textobj-between'           " between a char if af
Plugin 'vim-scripts/vis'                      " search/replace in visual-block
Plugin 'svermeulen/vim-easyclip'              " black-hole cut-paste
Plugin 'ryanoasis/vim-devicons'               " super-duper fonts
Plugin 'vim-scripts/iptables'                 " iptables filetype
Plugin 'vim-scripts/applescript.vim'          " applescript
Plugin 'vim-scripts/listmaps.vim'             " Provides :Listmaps , very useful to see which plugin set a map
Plugin 'Yggdroot/indentLine'                  " show lines for indenting
Plugin 'lakshmankumar12/jedi-vim'             " python goto definition
if has('nvim')
  Plugin 'Shougo/deoplete.nvim'               " Auto-completion
  Plugin 'Shougo/echodoc.vim'                 " Show function in echo-line
  Plugin 'zchee/deoplete-clang'               " c,c++ autocomplete
  Plugin 'zchee/deoplete-jedi'                " python autocomplete
  Plugin 'wbthomason/buildit.nvim'            " :Buildit .. async making
  Plugin 'jalvesaq/vimcmdline'                " Run lines individuall from a file
  "Plugin 'lyuts/vim-rtags'                    " rtags client
  Plugin 'brettanomyces/nvim-editcommand'     " <ctr-x><ctr-e> from the neovim-terminal
else
  Plugin 'sjl/clam.vim'                       " Clam shellcmd
  Plugin 'vim-scripts/OmniCppComplete'        " c-based language auto-complete
endif
Plugin 'SirVer/ultisnips'                     " snippets engine
Plugin 'honza/vim-snippets'                   " snippets repo
Plugin 'file://' . $HOME . '/github/vimfiles', {'rtp': 'tdef/'}         " my tdef file
Plugin 'vim-scripts/align'                    "  pre-req for vim-dragvisuals
Plugin 'vim-scripts/cecutil'                  "  pre-req for vim-dragvisuals
Plugin 'atweiden/vim-dragvisuals'             "  drag visual block
Plugin 'tmilloff/vim-address-bar'             "  one line buffer for filename
Plugin 'inkarkat/vim-ingo-library'            "  dependancy for vim-SearchHighlighting
Plugin 'inkarkat/vim-SearchHighlighting'      "  auto-highlight current word
Plugin 'dzeban/vim-log-syntax'                " syslog syntax highlight
Plugin 'lakshmankumar12/protectterm'          " Protect vim from closing when there are open terminals
Plugin 'rust-lang/rust.vim'                   " Rust plugin

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
set tabstop=4
set shiftwidth=4
set sidescroll=1
set grepprg=fgrep\ -n
if !has('nvim')
  set term=xterm-256color
  set t_Co=16
endif
set mouse=
set previewheight=15
set ruler
set history=100
set lbr
set laststatus=2
set nu
set relativenumber
autocmd BufReadPost quickfix setlocal norelativenumber
set noshowmode
set nosol
set splitright

map <Leader>mai i#include<stdio.h><CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>}<CR><Esc>kka<Tab>
map <Leader>cmai i#include<iostream><CR><CR>using namespace std;<CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>return 0;<CR>}<CR><Esc>kka<Tab>
map <Leader>typ itypedef struct<CR>{<CR><CR>}  ;<Esc>hi
map <Leader>pyth i#!/usr/bin/python<CR><CR>from __future__ import print_function<CR><CR>def main():<CR>pass<CR><C-D><CR>if __name__ == '__main__':<CR>main()<CR><Esc>kkkk
map <Leader>tail 100A <Esc>A;<Esc>h

set incsearch
set hlsearch
set nowrap
set expandtab
set showcmd
set ai
set cindent

syntax enable
set bg=dark
let g:solarized_termcolors=16
let g:solarized_termtrans=1
colorscheme solarized

set diffopt+=vertical
set csprg=~/bin/cscope

nmap gL <Esc>:cn<CR>
nmap gH <Esc>:cp<CR>
nmap - <Esc>:lprev<CR>
nmap + <Esc>:lnext<CR>

au FileType make setlocal noexpandtab
au FileType go setlocal nolist

let s:uname = system("echo -n \"$(uname)\"")
let g:my_home = $HOME

function! DumpToTmuxClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("tmux loadb -", getreg("\""))
endfunction

function! DumpPwdToTmuxClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("tmux loadb -", getcwd())
endfunction

function! DumpFullPathToClipBoard()
  if s:uname == "Darwin"
    call system("pbcopy -pboard general", expand("%:p"))
  else
    call system("to_host_clip.sh", expand("%:p"))
  endif
endfunction

map gwp   <Esc>:call DumpFullPathToClipBoard()<CR>

function! DumpFullPathToTmuxClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("tmux loadb -", expand("%:p"))
endfunction
map gwq   <Esc>:call DumpFullPathToTmuxClipBoard()<CR>

function! DumpTagToTmuxClip()
    call system("tmux loadb -", tagbar#currenttag('%s', 'No current tag'))
endfunction
map gwu   <Esc>:call DumpTagToTmuxClip()<CR>

function! DumpToClipBoard()
  if s:uname == "Darwin"
    call system("pbcopy -pboard general", getreg("\""))
  else
    call system("bash -ci to_host_clip", getreg("\""))
    "call system("xsel -i -b", getreg("\""))
    "call system("ssh -p $(cat /home/lakshman_narayanan/.mymacport) $(cat $HOME/.mymacusername)@$(cat /home/lakshman_narayanan/.mymacip) pbcopy", getreg("\""))
  endif
endfunction

map <Leader>clip :call DumpToClipBoard()<CR>
vmap <C-c> y:call DumpToClipBoard()<CR>
vmap gc    y:call DumpToClipBoard()<CR>
vmap <C-b> y:call DumpToTmuxClipBoard()<CR>
vmap gt    y:call DumpToTmuxClipBoard()<CR>
nmap gb    y:call DumpToClipBoard()<CR>
nmap gb    :r !xsel -b<CR>

"dont lose anything on a accidental ctrl-u/w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
vmap s <Plug>(easymotion-s)
"nmap S <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap <Leader>w <Plug>(easymotion-bd-w)
vmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>W <Plug>(easymotion-bd-W)
vmap <Leader>W <Plug>(easymotion-bd-W)
nmap <Leader>e <Plug>(easymotion-bd-e)
vmap <Leader>e <Plug>(easymotion-bd-e)
nmap <Leader>E <Plug>(easymotion-bd-E)
vmap <Leader>E <Plug>(easymotion-bd-E)

"black-hole copying
let g:EasyClipUseCutDefaults = 0
nmap ghd <Plug>MoveMotionPlug
"In visual mode, both d & D do the same.
vmap ghd ygvd
vmap ghD ygvd
nmap ghD <Plug>MoveMotionLinePlug
nmap ghs <Plug>SubstituteOverMotionMap

"shrink visual block by one char on either side (assuming we are on left)
vmap <C-S> oloh


"vim-sneak mapping
nmap <Leader>s <Plug>(SneakStreak)
nmap <Leader>S <Plug>(SneakStreakBackward)

"Form markwords
highlight MarkWord1 ctermbg=57 ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord2 ctermbg=48 ctermfg=black guibg=#8CCBEA guifg=Black
highlight MarkWord3 ctermbg=88 ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord4 ctermbg=6 ctermfg=black guibg=#8CCBEA guifg=Black
highlight MarkWord5 ctermbg=red ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord6 ctermbg=brown ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord7 ctermbg=magenta ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord8 ctermbg=blue ctermfg=white guibg=#8CCBEA guifg=Black

if has('nvim')
    highlight TermCursor   ctermbg=130 ctermfg=white guibg=#8CCBEA guifg=Black
    highlight TermCursorNC ctermbg=29  ctermfg=white guibg=#8CCBEA guifg=Black
endif

" NerdTree
map <C-n> :NERDTreeToggle<CR>
map gwe :NERDTreeFind<CR>

au! Filetype qf setlocal statusline="%t%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''} win:%{WindowNumber()}%=%-15(%l,%c%V%) %P"

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_powerline_fonts=1
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 30,
      \ 'b': 100,
      \ 'c': 20,
      \ 'gutter': 100,
      \ 'f': 30,
      \ 'x': 20,
      \ 'y': 100,
      \ 'z': 30,
      \ 'warning': 200,
      \ 'error': 200,
      \ }
let g:airline_theme='solarized'
let g:airline_section_c =
      \"%{winnr()}: ".
      \"%<%f%m %#__accent_red#".
      \"%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"
function! AirlineThemePatch(palette)
  if g:airline_theme == 'solarized'
    "greenish
    let a:palette.normal.airline_a = [ '#1c1c1c', '#5fff00', 234, 82 ]
    let a:palette.normal.airline_z = [ '#1c1c1c', '#5fff00', 234, 82 ]
    "blue
    let a:palette.visual.airline_a = [ '#ffffff', '#0087ff', 255, 33 ]
    let a:palette.visual.airline_z = [ '#ffffff', '#0087ff', 255, 33 ]
    "violetish
    let a:palette.insert.airline_a = [ '#3a3a3a', '#af00ff', 237, 129 ]
    let a:palette.insert.airline_z = [ '#3a3a3a', '#af00ff', 237, 129 ]
    "reddish
    let a:palette.replace.airline_a = [ '#ffffff', '#ff005f', 255, 197 ]
    let a:palette.replace.airline_z = [ '#ffffff', '#ff005f', 255, 197 ]
    "pinkish
    if has_key(a:palette, 'terminal')
        let a:palette.terminal.airline_a = [ '#ffffff', '#ff005f', 255, 207 ]
        let a:palette.terminal.airline_z = [ '#ffffff', '#ff005f', 255, 207 ]
    endif
  endif
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnametruncate = 10
set rtp+=~/.fzf
let g:fzf_command_prefix = 'Fzf'

" no omnicomplete preview
set completeopt-=preview

" Reset the listchars - This is a native vim setting
set listchars=""
" make tabs visible
set listchars=tab:↔•        "⇢‧
" show trailing spaces as dots
set listchars+=trail:…
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:►
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:◄
"set listchars+=eol:←  "  ↲
set list

set fillchars=vert:│,fold:-
hi VertSplit ctermbg=NONE guibg=NONE

" Unite
autocmd FileType unite imap <buffer> <Leader>x <Plug>(unite_exit)
autocmd FileType unite imap <buffer> kj <Esc>
if has('nvim')
  nnoremap ghb <Esc>:set nopaste<CR><Esc>:Denite -ignorecase buffer<CR>
  nnoremap gho <Esc>:set nopaste<CR><Esc>:Denite -ignorecase buffer file file_mru<CR>
  nnoremap ghO <Esc>:set nopaste<CR><Esc>:Denite -ignorecase buffer file file_rec file_mru<CR>
  nnoremap gh/ <Esc>:set nopaste<CR><Esc>:Denite -ignorecase line<CR>
  nnoremap ghr <Esc>:set nopaste<CR><Esc>:DeniteResume<CR>
  nnoremap gh? <Esc>:set nopaste<CR><Esc>:Denite -ignorecase -no-quit -keep-focus line<CR>
  nnoremap ghy <Esc>:set nopaste<CR><Esc>:Denite -ignorecase register history/yank<CR>
  let g:zoomwin_localoptlist = ["ai","ar","bh","bin","bl","bomb","bt","cfu","ci","cin","cink","cino","cinw","cms","com","cpt","diff","efm","eol","ep","et","fenc","fex","ff","flp","fo","ft","gp","imi","ims","inde","inex","indk","inf","isk","kmp","lisp","mps","ml","ma","mod","nf","ofu","pi","qe","ro","sw","si","sts","spc","spf","spl","sua","swf","smc","syn","ts","tw","udf","wfh","wfw","wm"]
else
  nnoremap ghb <Esc>:set nopaste<CR><Esc>:Unite -ignorecase buffer<CR>
  nnoremap gho <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase buffer file file_mru<CR>
  nnoremap ghO <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase buffer file file_rec file_mru<CR>
  nnoremap gh/ <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase line<CR>
  nnoremap ghr <Esc>:set nopaste<CR><Esc>:UniteResume<CR>
  nnoremap gh? <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase -no-quit -keep-focus line<CR>
  nnoremap ghy <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase register history/yank<CR>
endif

if filereadable ("../cscope.out")
  execute "cs add ../cscope.out .."
endif
if filereadable ("../others.out")
  execute "cs add ../others.out .."
endif
if filereadable ("others.out")
  execute "cs add others.out"
endif

let g:shelltoset=g:my_home . "/bin/zsh"
"Hose overrides
let g:hostname=system("hostname -s")
if stridx(g:hostname,"mforge3") != -1
    let g:shelltoset="/home/lakshman_narayanan/gitlab/aryaka-scripts/m3_overrides/zsh"
endif

if has('nvim')
  execute "source " . g:my_home . "/.vim/plugin/lakshman.vim"
  execute "source " . g:my_home . "/.vim/plugin/sn_git.vim"
  execute "source " . g:my_home . "/.vim/plugin/gitlsfiles.vim"
  execute "source " . g:my_home . "/.vim/plugin/svn_lakshman.vim"
  set scrollback=100000
  set timeout               " wait for 1s for keymaps
  let g:python_host_prog = g:my_home . '/bin/python2.7'
  let g:python3_host_prog = g:my_home . '/bin/python'
  let &shell = g:shelltoset
  " nvim-editcommand
  let g:editcommand_prompt = '─'
  tmap <M-o> <Plug>EditCommand

  augroup MyTermMappings
    autocmd!
    autocmd TermOpen * nnoremap <buffer> q a
    autocmd TermOpen * nnoremap <buffer> gp a<C-P>
  augroup END
endif

let g:ag_apply_lmappings = 0
let g:ag_apply_qmappings = 0

"cmdline.nvim
let cmdline_app           = {}
let cmdline_app["python"] = "python3"

"start deoplete
let g:deoplete#enable_at_startup = 0
if s:uname == "Darwin"
    let g:deoplete#sources#clang#libclang_path='/usr/local/opt/llvm/lib/libclang.dylib'
    let g:deoplete#sources#clang#clang_header='/usr/local/opt/llvm/include'
else
    let g:deoplete#sources#clang#libclang_path=g:my_home . '/install/clang/local/lib.hide/libclang.so.3.6'
    let g:deoplete#sources#clang#clang_header=g:my_home . '/install/clang/local/include/clang'
endif
let g:deoplete#sources#jedi#python_path=g:my_home . '/bin/python3'
let g:echodoc#enable_at_startup = 1

"jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<Leader>gR'
let g:jedi#usages_command = '<Leader>gu'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>_K'
let g:jedi#auto_close_doc = 1

let g:rtagsRcCmd=g:my_home . '/bin/rc'

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

"indentLine
let g:indentLine_char='┃'   " '┊'

"last-tab!
let g:lasttab = 1
nnoremap gMM :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" vim-markdown plugin settings
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_toc_autofit = 1
autocmd FileType markdown syntax sync fromstart
autocmd FileType jira_op syntax sync fromstart

"ultisnip directories
" myultisnippets just works because runtimepath include this vimrepo, via tdef!
let g:UltiSnipsSnippetDirectories=["UltiSnips", "myultisnippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" gdb file-type
au BufNewFile,BufRead *.gdb         setf gdb

" Reference: http://www.futurile.net/2016/03/19/vim-surround-plugin-tutorial/
" new surround target
"    :echo char2nr('o') which returns 111
let g:surround_111 = "```\r```"
let g:surround_{char2nr('o')} = "```\r```"
let g:surround_107 = "`\r`"
let g:surround_{char2nr('k')} = "`\r`"

" Drag-visual
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" DONT TYPE ANYTHING HERE SO THAT CENTOS-BRANCH CAN
" SAFELY ADD ITS OVERRIDES WITHOUT ISSUES





" ***********


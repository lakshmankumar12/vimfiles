set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'antiAgainst/cscope-macros.vim'        " Brings in the ctrl-\ <g|s|c> shortcuts
Plugin 'tpope/vim-fugitive'                   " The awesome git plugin. Period.
Plugin 'jreybert/vimagit'                     " :Magit command
Plugin 'scrooloose/nerdtree'                  " Directory browser
Plugin 'Xuyuanp/nerdtree-git-plugin'          " Show gittish info when nerd-tree is invoked
Plugin 'justinmk/vim-sneak'                   " goto any location using s<char>
Plugin 'jiangmiao/auto-pairs'                 " for automatically adding braces
Plugin 'tmhedberg/matchit'                    " % given a new life
Plugin 'Lokaltog/vim-easymotion'              " <Leader>hjkl
Plugin 'vim-scripts/python_match.vim'         " % for if/elif/else, try/except/catch in py. Also use [% to go to start of block 
Plugin 'sjl/clam.vim'                         " Clam shellcmd
Plugin 'vim-scripts/OmniCppComplete'          " c-based language auto-complete
Plugin 'vim-airline/vim-airline'              " look and feel with powerline'ish fonts
Plugin 'vim-airline/vim-airline-themes'       " More themese for airline
Plugin 'majutsushi/tagbar'                    " Enables the c-function names with g:airline#extensions#tagbar#enabled below.
Plugin 'rking/ag.vim'                         " Brings :Ag :LAg commands and silver-searcher
Plugin 'tarmolov/TabLineNumbers.vim'          " prints numbers in each tab
Plugin 'Shougo/vimproc.vim'                   " Needed for unite
Plugin 'vim-scripts/AnsiEsc.vim'              " To view files having ansi-esc chars.
Plugin 'airblade/vim-gitgutter'               " Puts up a line(gutter) in the left column with git'ish information
Plugin 'scrooloose/nerdcommenter'             " Comment/remove-comment blocks quickly
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ternjs/tern_for_vim'
Plugin 'junegunn/fzf.vim'                     " :Fzf and other commands
Plugin 'altercation/vim-colors-solarized.git' " Solarized vim
Plugin 'regedarek/ZoomWin'                    " Close other windows and re-open them again
Plugin 'yssl/QFEnter'                         " <Leader><CR> on quickfix/loc-list will open in a new vert split.
Plugin 'fatih/vim-go'                         " One stop go plugin
Plugin 'godlygeek/tabular'                    " Auto-align lines.
Plugin 'tpope/vim-surround'                   " add quotes(surroundings) to a word etc..
Plugin 'jeetsukumaran/vim-indentwise'         " help navigating blocks based on indent.
Plugin 'vim-scripts/Mark--Karkat'             " Multiple color search
Plugin 'tpope/vim-speeddating'                " Pre-req for vim-orgmode
Plugin 'jceb/vim-orgmode'                     " Org style
Plugin 'guns/xterm-color-table.vim'           " :XtermColorTable -- help to know color numbers
Plugin 'Shougo/unite.vim'                     " :Unite
Plugin 'Shougo/neomru.vim'                    " :for file_mru option in Unite
Plugin 'Shougo/neoyank.vim'                   " :Unite history/yank
Plugin 'kana/vim-textobj-user'                " pre-req for indent/line
Plugin 'kana/vim-textobj-indent'              " indent text-object
Plugin 'kana/vim-textobj-line'                " line text-object
Plugin 'bps/vim-textobj-python'               " python function/class selector
Plugin 'thinca/vim-textobj-between'           " between a char if af
Plugin 'vim-scripts/vis'                      " search/replace in visual-block

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
set shiftwidth=2
set sidescroll=1
set grepprg=fgrep\ -n
if !has('nvim')
  set term=xterm-256color
  set t_Co=16
endif
set mouse=a
set previewheight=15
set ruler
set history=100
set lbr
set laststatus=2
set nu
set relativenumber

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
set csprg='/home/lnara002/bin/cscope'

nmap gL <Esc>:cn<CR>
nmap gH <Esc>:cp<CR>
nmap - <Esc>:lprev<CR>
nmap + <Esc>:lnext<CR>

au FileType make setlocal noexpandtab
au FileType go setlocal nolist

function! DumpToTmuxClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("tmux loadb -", getreg("\""))
endfunction

function! DumpToClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("xsel -i -b", getreg("\""))
  call system("xsel -i -b", getreg("\""))
endfunction

function! DumpNameToClipBoard()
  "call writefile(split(@","\n"), '/dev/clipboard')
  call system("xsel -i -b", expand("%:p"))
  call system("xsel -i -b", expand("%:p"))
  call system("xsel -i -a", expand("%:p"))
endfunction

map <Leader>clip :call DumpToClipBoard()<CR>
vmap <C-c> y:call DumpToClipBoard()<CR>
vmap gb    y:call DumpToClipBoard()<CR>
vmap <C-b> y:call DumpToTmuxClipBoard()<CR>
vmap gt    y:call DumpToTmuxClipBoard()<CR>
nmap gb    y:call DumpToClipBoard()<CR>
nmap gb    :r !xsel -b<CR>
map <Leader>cname :call DumpNameToClipBoard()<CR>

"easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
"nmap S <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"vim-sneak mapping
nmap <Leader>s <Plug>(SneakStreak)
nmap <Leader>S <Plug>(SneakStreakBackward)

"Form markwords
highlight MarkWord1 ctermbg=red ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord2 ctermbg=brown ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord3 ctermbg=magenta ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord4 ctermbg=blue ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord5 ctermbg=6 ctermfg=black guibg=#8CCBEA guifg=Black
highlight MarkWord6 ctermbg=57 ctermfg=white guibg=#8CCBEA guifg=Black
highlight MarkWord7 ctermbg=48 ctermfg=black guibg=#8CCBEA guifg=Black
highlight MarkWord8 ctermbg=88 ctermfg=white guibg=#8CCBEA guifg=Black

" NerdTree
map <C-n> :NERDTreeToggle<CR>

au! Filetype qf setlocal statusline="%t%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''} win:%{WindowNumber()}%=%-15(%l,%c%V%) %P"

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_powerline_fonts=1
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 20,
      \ 'b': 100,
      \ 'c': 20,
      \ 'gutter': 100,
      \ 'x': 20,
      \ 'y': 100,
      \ 'z': 20,
      \ 'warning': 100,
      \ 'error': 100,
      \ }
let g:airline_theme='solarized'
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
  endif
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'


set rtp+=/home/lnara002/.fzf
let g:fzf_command_prefix = 'Fzf'

" no omnicomplete preview
set completeopt-=preview

" Reset the listchars - This is a native vim setting
set listchars=""
" make tabs visible
set listchars=tab:▸▸
" show trailing spaces as dots
set listchars+=trail:•
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<
set list

" Unite
autocmd FileType unite imap <buffer> <Leader>x <Plug>(unite_exit)
autocmd FileType unite imap <buffer> kj <Esc>
nnoremap gho <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase buffer file file_rec file_mru<CR>
nnoremap gh/ <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase line<CR>
nnoremap ghr <Esc>:set nopaste<CR><Esc>:UniteResume<CR>
nnoremap gh? <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase -no-quit -keep-focus line<CR>
nnoremap ghy <Esc>:set nopaste<CR><Esc>:Unite -start-insert -ignorecase history/yank<CR>

" DONT TYPE ANYTHING HERE SO THAT CENTOS-BRANCH CAN
" SAFELY ADD ITS OVERRIDES WITHOUT ISSUES





" ***********


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-scripts/MultipleSearch'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'antiAgainst/cscope-macros.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'justinmk/vim-sneak'
Plugin 'edsono/vim-matchit'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/python_match.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-scripts/ShowFunc.vim'
Plugin 'sjl/clam.vim'                         "Clam shellcmd
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/vimtabs.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'                    "Enables the c-function names with g:airline#extensions#tagbar#enabled below.
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tarmolov/TabLineNumbers.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'vim-scripts/AnsiEsc.vim'
Plugin 'ofavre/vimcat.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ternjs/tern_for_vim'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-scripts/QFixToggle'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'regedarek/ZoomWin'

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
set previewheight=20
set ruler
set history=100
set lbr

map <Leader>mai i#include<stdio.h><CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>}<CR><Esc>kka<Tab>
map <Leader>cmai i#include<iostream><CR><CR>using namespace std;<CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>return 0;<CR>}<CR><Esc>kka<Tab>
map <Leader>typ itypedef struct<CR>{<CR><CR>}  ;<Esc>hi
map <Leader>pyth i#!/usr/bin/python<CR><CR>from __future__ import print_function<CR><CR>def main():<CR>pass<CR><C-D><CR>if __name__ == '__main__':<CR>main()<CR><Esc>kkkk

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
set csprg='/home/lnara002/software/cscope/cscope-15.8a/postinstall/bin/cscope'

map + <Esc>:cn<CR>
map - <Esc>:cp<CR>

au FileType make setlocal noexpandtab

"for the ShowFunc.vim plugin.
let g:showfuncctagsbin = "/home/lnara002/software/ctags/ctags-5.8/postinstall/bin/ctags"
let g:ShowFuncScanType = "current"
map  <Leader>shfn  <Plug>ShowFunc
map! <Leader>shfn  <Plug>ShowFunc

"for the ctags.vim plugin.
let g:ctags_path="/home/lnara002/software/ctags/ctags-5.8/postinstall/bin/ctags"
let g:ctags_statusline=1
let g:ctags_title=0
let generate_tags=1


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
nmap gb    y:call DumpToClipBoard()<CR>
nmap gb    :r !xsel -b<CR>
map <Leader>cname :call DumpNameToClipBoard()<CR>

"easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap S <Plug>(easymotion-s)
"nmap S <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


"vim-sneak mapping
nmap <Leader>s <Plug>(SneakStreak)
nmap <Leader>S <Plug>(SneakStreakBackward)

"For MultipleSearch.vim
let g:MultipleSearchMaxColors = 8
"   foreground and background
let g:MultipleSearchColorSequence = "red,blue,green,magenta,cyan,gray,brown,yellow"
let g:MultipleSearchTextColorSequence = "white,white,black,white,black,black,white,black"

" DirDiff mapping enabled
let g:DirDiffEnableMappings=1

" NerdTree
map <C-n> :NERDTreeToggle<CR>

au! Filetype qf setlocal statusline="%t%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''} win:%{WindowNumber()}%=%-15(%l,%c%V%) %P"

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_powerline_fonts=1
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 20,
      \ 'b': 150,
      \ 'c': 20,
      \ 'gutter': 150,
      \ 'y': 150,
      \ 'z': 20,
      \ 'warning': 150,
      \ 'error': 150,
      \ }
let g:airline_theme='molokai'

"for ctrlp.vim
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_show_hidden = 1

set rtp+=/home/lnara002/github/fzf
let g:fzf_command_prefix = 'Fzf'

" no omnicomplete preview
set completeopt-=preview

" DONT TYPE ANYTHING HERE SO THAT CENTOS-BRANCH CAN
" SAFELY ADD ITS OVERRIDES WITHOUT ISSUES





" ***********

"for ag.vim
let g:agprg="/home/lnara002/software/ag/the_silver_searcher-0.30.0/postinstall/bin/ag --column"

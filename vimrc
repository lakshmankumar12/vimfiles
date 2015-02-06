set tabstop=4
set shiftwidth=2
set sidescroll=1
set grepprg=fgrep\ -n
set term=xterm
set mouse=a
set previewheight=20
set ruler
set nocp
set history=100
filetype plugin on


map ~mai i#include<stdio.h><CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>}<CR><Esc>kka<Tab>
map ~cmai i#include<iostream><CR><CR>using namespace std;<CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>return 0;<CR>}<CR><Esc>kka<Tab>
map ~typ itypedef struct<CR>{<CR><CR>}  ;<Esc>hi

set incsearch
set hlsearch
set nowrap
set expandtab
set showcmd
set ai
set cindent

if !has("gui_running")
    set t_Co=8
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
endif

syntax enable

highlight search term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
highlight comment term=underline ctermfg=6 guifg=DarkCyan

map + <Esc>:cn<CR>
map - <Esc>:cp<CR>

au FileType make setlocal noexpandtab

"for the ShowFunc.vim plugin.
let g:showfuncctagsbin = "usr/local/timostools/ctags"
let g:ShowFuncScanType = "current"

"for the ctags.vim plugin.
let g:ctags_path='/usr/local/timostools/ctags'
let g:ctags_statusline=1
let g:ctags_title=0
let generate_tags=1

if has("gui_running")
  set bg=light
else
  set bg=dark
endif

function! DumpToClipBoard()
  call writefile(split(@","\n"), '/dev/clipboard')
endfunction

cmap p$$<CR> call DumpToClipBoard()<CR>
map ~clip :call DumpToClipBoard()<CR>
map ~cip :call DumpToClipBoard()<CR>
map <F2> :call DumpToClipBoard()<CR>





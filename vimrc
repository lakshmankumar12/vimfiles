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

function BoxgrepBoxer()
    !boxgrep . "\<<cword>\>"
    cf grepOp
    cope
endfunction

function BoxgrepPmm()
    !boxgrep sess/sgsn/sgsn-app/pmm "\<<cword>\>"
    cf grepOp
    cope
endfunction

function BoxgrepAccess()
    !boxgrep sess/sgsn/sgsn-app/access "\<<cword>\>"
    cf grepOp
    cope
endfunction

function BoxgrepSess()
    !boxgrep sess "\<<cword>\>"
    cf grepOp
    cope
endfunction

function BoxgrepDp()
    !boxgrep sess/sgsn/sgsn-app/dp "\<<cword>\>"
    cf grepOp
    cope
endfunction

map ~grb <Esc>:call BoxgrepBoxer()<CR>
map ~grp <Esc>:call BoxgrepPmm()<CR>
map ~gra <Esc>:call BoxgrepAccess()<CR>
map ~grs <Esc>:call BoxgrepSess()<CR>
map ~grd <Esc>:call BoxgrepDp()<CR>
map ~co <Esc>:cope<CR>
map ~cc <Esc>:ccl<CR>
map ~ju <Esc><C-W>h:vert res 25<CR>2<C-W>l:vert res +25<CR><C-W>h
map ~wm <Esc>:WMToggle<CR><Esc>:WMToggle<CR>
map ~vsp <Esc>:vsplit<CR><Esc><C-W>h:vert res 25<CR>2<C-W>l<Esc>:vert res 65<CR><C-W>h
map ~vki <Esc>:<C-W>l<Esc>:q<CR>:WMToggle<CR>:WMToggle<CR>
map ~res <Esc>:vert res +10<CR>
map ~bgd <Esc>:set bg=dark<CR>
map ~bgl <Esc>:set bg=light<CR>
map ~csq <Esc>:set csqf=s-,g-,d-,c-,t-,e-,f-,i-<CR>
map ~csn <Esc>:set csqf=s0,g0,d0,c0,t0,e0,f0,i0<CR>
map <C-W>a <C-W>k<C-W>c
map <C-W>e <C-W>j<C-W>c
map <C-W>y <C-W>b<Esc>:res 10<CR><C-W>k
map + <Esc>:cn<CR>
map - <Esc>:cp<CR>

au FileType make setlocal noexpandtab
"au FileType c call omni#cpp#complete#Init()

"for the ShowFunc.vim plugin.
let g:showfuncctagsbin = "/ws/lakskuma-bgl/software/ctags/ctags-5.8/postinstall/bin/ctags"
let g:ShowFuncScanType = "current"

"for the ctags.vim plugin.
let g:ctags_path= "/ws/lakskuma-bgl/software/ctags/ctags-5.8/postinstall/bin/ctags"
let g:ctags_statusline=1 
let g:ctags_title=0
let generate_tags=1

set bg=dark

"to bring cscope results under quickfix
"set csqf=s-,g-,d-,c-,t-,e-,f-,i-

if hostname()[0:2] == "bxb"
  set csprg=/usr/bin/cscope
else 
  set csprg=/ws/lakskuma-bgl/software/cscope/cscope-15.7a/postinstall/bin/cscope
endif

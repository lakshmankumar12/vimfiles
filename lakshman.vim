nmap <Leader>name        <Esc>:echo expand("%:p")<CR>
nmap <Leader>cmd         <Esc>:call GetCommandOutputOnNewTab()<CR>
nmap <Leader>mshed       <Esc>:call ShedM()<CR>
nmap <Leader>css         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"s")<CR>
nmap <Leader>csg         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"g")<CR>
nmap <Leader>csc         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"c")<CR>
nmap <Leader>adds        <Esc>:call Addspaces()<CR>
nmap <Leader>only        <Esc>:call KeepOnlyWindowWithLocationList()<CR>
"remapping to accomodate typos
nmap <Leader>conly        <Esc>:call KeepOnlyWindowWithLocationList()<CR>
nmap [u            <C-w>h<C-w>c
nmap ]u            <C-w>l<C-w>c
nmap [t            <C-w>k<C-w>c
nmap [b            <C-w>j<C-w>c
nmap <c-h>         <C-w>h
nmap <c-j>         <C-w>j
nmap <c-k>         <C-w>k
nmap <c-l>         <C-w>l
" Who uses ex mode these days!
nmap Q            <Esc>:tabclose<CR>
" i dont use ZZ/ZQ much. Anything else on Z?!
nmap Z            :<C-U>call CloseWindowsInBottomAndOpenLocationList(v:count1)<CR>
nmap zp           <Esc>:lopen<CR>
" neither do i use S
nmap S            <Esc>
" Y is same yy. So, lets do something useful
nmap Y            y$:call DumpToClipBoard()<CR>
nmap gc           <Esc>:call KeepOnlyWindowWithLocationList()<CR>
nmap gl           <Esc>:FZF<CR>
nmap gww          <Esc>:update<CR>
nmap gwh          <C-w>h
nmap gwj          <C-w>j
nmap gwk          <C-w>k
nmap gwl          <C-w>l
nmap gw=          <C-w>=
nmap gwc          <C-w>c
nmap gwv          <C-w>v
nmap gws          <C-w>s
nmap gwo          <Plug>ZoomWin
nmap gwt          <Esc>:tabnew %<CR>
nmap gwH          <C-w>h<C-w>c
nmap gwJ          <C-w>j<C-w>c
nmap gwK          <C-w>k<C-w>c
nmap gwL          <C-w>l<C-w>c

"cscope'ish
nmap gxs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap gxg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap gxc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap gxt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap gxe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap gxf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap gxi :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap gxd :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap gxx <C-t>
nmap gxo <C-o>
nmap gxS :vsplit<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap gxG :vsplit<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap gxC :vsplit<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>

nmap gy           <Esc>:set paste!<CR>
nmap gB           <Esc>:FzfBuffers<CR>
call togglebg#map("gz")
imap kj           <Esc>
cmap kj           <Esc>
nmap gp           <Esc>p`[
nmap gP           <Esc>P`[
nmap zg           <Esc>:vert scs find g <C-R>=expand("<cword>")<CR><CR>	
"in visual-line mode, i need to select lines, and i keep pressing J
vmap J            j
"scroll preview window from another window
nnoremap <Leader>pd   <Esc>:wincmd P<CR><C-D>:wincmd p<CR>
nnoremap <Leader>pu   <Esc>:wincmd P<CR><C-U>:wincmd p<CR>
nmap <Leader>ln   <C-w>h<Esc>:q<CR><C-w>P<C-n>
nmap <Leader>lp   <C-w>h<Esc>:q<CR><C-w>P<C-p>
nmap <Leader>hn   :q<CR><C-w>P<C-n>
nmap <Leader>hp   :q<CR><C-w>P<C-p>
nmap <Leader>gfunc    <Esc>:call FindFunctionFromTags()<CR>
nnoremap <Leader>gdb  <Esc>:Gdiff base<CR>gg<Esc>:wincmd l<CR>

function! GetCommandOutputOnNewTab()
  let s:cmdName = input("Enter command:")
  execute "tabnew"
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  redir! > /tmp/vimtempfile
  echo "Buffer number is " . bufnr('%')
  redir END
  silent execute "0r !cat /tmp/vimtempfile"
  silent 
endfunction

function! ShedM()
  execute "%s///g"
endfunction

function! LoadCscopeToQuickFix(currword, oper)
  execute "normal mZ"
  execute "set csqf=" . a:oper . "-"
  execute "lcs find " a:oper . " " . a:currword
  execute "lopen"
  execute "wincmd p"
  execute "normal `Z"
  execute "set csqf="
endfunction

function! Addspaces()
  let s:cmdName = input("Enter column:")
  execute "normal 50A "
  execute "normal " . s:cmdName ."|D"
  execute "normal A"
endfunction

function! KeepOnlyWindowWithLocationList()
  execute "only"
  execute "lopen"
  execute "wincmd p"
endfunction

function! CloseWindowsInBottomAndOpenLocationList(count)
  let l:c = 1
  execute "wincmd b"
  execute "close"

  while l:c <= a:count
      execute "wincmd j"
      execute "close"
      let l:c += 1
  endwhile
  execute ":lopen"
endfunction

function! FindFunctionFromTags()
  let s:f_name=system('percol --tty=$TTY --match-method=regex ../gtp_tags_f | awk '' { print $1 }'' ')
  if !v:shell_error
     let s:new_var = substitute(s:f_name, '\n\+$', '', '')
     echom "got " . s:new_var
     call LoadCscopeToQuickFix(s:f_name,"s")
  else
     echom "Error:" . v:shell_error
     echom "f_name:" . s:f_name
  endif
endfunction

function! ShowMp3Function()
  execute "%d"
  execute "0r !find_tags_of_files.py *mp3"
endfunction

function! MakeMp3Function()
  let s:cmd="!/home/lnara002/bin/prepare_tag_commands.py " . expand("%:p") . " > /tmp/cmds"
  execute s:cmd
  let s:cmd="!chmod +x /tmp/cmds"
  execute s:cmd
  let s:cmd="!/tmp/cmds"
  execute s:cmd
  execute "!ls *mp3 | while read i ; do id3v2 -s $i ; done"
  execute "%d"
  execute "0r !find_tags_of_files.py *mp3"
endfunction

command! Showmp3 call ShowMp3Function()
command! Makemp3 call MakeMp3Function()

" Taken from : http://github.com/nvie/vim-togglemouse
fun! ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

nmap gV   <Esc>:call ToggleMouse()<CR>

function! MoveToDefintionOfMember(word)
  let l:save_word = a:word
  execute "normal mZ"
  "we are at member. Go past arrow or dot to the var-name of struct
  execute "normal 2ge"
  "go to local definition
  execute "normal gd"
  "go to type name. It could be a pointer or direct struct
  execute "normal geb"
  "split
  execute ":vsplit"
  "go to definition
  execute ":cs find g ". expand("<cword>")
  "high light word
  execute "normal ?\\<" . l:save_word . "\\>?s\<CR>"
  let @/="\\<" . l:save_word . "\\>"
  execute "normal zz"
  "go back
  execute "wincmd l"
  execute "normal `Z"
  execute "normal zz"
endfunction

nmap gS <Esc>:call MoveToDefintionOfMember(expand("<cword>"))<CR>

" DONT TYPE ANYTHING HERE SO THAT CENTOS-BRANCH CAN
" SAFELY ADD ITS OVERRIDES WITHOUT ISSUES





" ***********

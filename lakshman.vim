nmap <special> <F8> :call ViewNormalLogRealign()<CR>

nmap Y y$
nmap ~nlog     <Esc>:call ViewNormalLog()<CR>
nmap ~nrea     <Esc>:call ViewNormalLogRealign()<CR>
nmap <Page-Down>  <Esc>:call ScrollLogDown()<CR>
nmap <Leader>fdd    <Esc>:call ListFilesInThisDir()<CR>
nmap <Leader>name        <Esc>:echo expand("%:p")<CR>
nmap <Leader>cmd         <Esc>:call GetCommandOutputOnNewTab()<CR>
nmap <Leader>lcmd        <Esc>:call ListOfFilesOnLocationList()<CR>
nmap <Leader>mshed       <Esc>:call ShedM()<CR>
nmap <Leader>css         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"s")<CR>
nmap <Leader>csg         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"g")<CR>
nmap <Leader>csc         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"c")<CR>
nmap <Leader>adds        <Esc>:call Addspaces()<CR>
nmap <Leader>nerd        <Esc>:NERDTreeToggle<CR>
nmap <Leader>pas         <Esc>:set paste<CR>
nmap <Leader>nopas       <Esc>:set nopaste<CR>
nmap <Leader>only        <Esc>:call KeepOnlyWindowWithQuickFix()<CR>
"remapping to accomodate typos
nmap <Leader>conly        <Esc>:call KeepOnlyWindowWithQuickFix()<CR>
nmap <Leader>bgl          <Esc>:set bg=light<CR>
nmap <Leader>bgd          <Esc>:set bg=dark<CR>
nmap [u            <C-w>h<C-w>c
nmap ]u            <C-w>l<C-w>c
nmap [t            <C-w>k<C-w>c
nmap [b            <C-w>j<C-w>c
nmap <c-h>         <C-w>h
nmap <c-j>         <C-w>j
nmap <c-k>         <C-w>k
nmap <c-l>         <C-w>l
nmap Q            <Esc>:tabclose<CR>
" i dont use Z<anything> much
nmap Z            <Esc>:call QFixToggle(0)<CR>
" neither do i use S
nmap s            <Esc>
nmap gc           <Esc>:call KeepOnlyWindowWithQuickFix()<CR>
nmap gl           <Esc>:FZF<CR>
nmap gw           <Esc>:update<CR>
nmap gx           <Esc>:close<CR>
nmap gy           <Esc>:set paste!<CR>
nmap gG           <Esc>:call PanosTags("../tags_f")<CR>
nmap gA           <Esc>:call PanosTags("../tags_s")<CR>
nmap gM           <Esc>:call PanosTags("../tags_m")<CR>
nmap gB           <Esc>:FzfBuffers<CR>
call togglebg#map("gz")
imap kj           <Esc>
cmap kj           <Esc>
nmap gp           <Esc>p`[
nmap gP           <Esc>P`[
"in visual-line mode, i need to select lines, and i keep pressing J
vmap J            j
nnoremap <Leader>pd   <Esc>:wincmd P<CR><C-D>:wincmd p<CR>
nnoremap <Leader>pu   <Esc>:wincmd P<CR><C-U>:wincmd p<CR>
nmap <Leader>ln   <C-w>h<Esc>:q<CR><C-w>P<C-n>
nmap <Leader>lp   <C-w>h<Esc>:q<CR><C-w>P<C-p>
nmap <Leader>hn   :q<CR><C-w>P<C-n>
nmap <Leader>hp   :q<CR><C-w>P<C-p>
nmap <Leader>gfunc    <Esc>:call FindFunctionFromTags()<CR>
nnoremap <Leader>gdb  <Esc>:Gdiff base<CR><C-w>lgg

function! FoldTillTopBrace()
  execute "normal mak$mb"
  let l:a=getline(".")[col(".") - 1]
  if l:a == '}'
    execute "normal %"
  endif
  execute "normal [{j0zf`b`a"
endfunction

function! ViewNormalLog()
  execute "only"
  execute "set nowrap"
  execute "vsplit"
  execute "vsplit"
  execute "1 wincmd w"
  execute "normal 10|"
  execute "normal zs"
  execute "vert res 15"
  execute "2 wincmd w"
  execute "normal 26|"
  execute "normal zs"
  execute "vert res 25"
  execute "3 wincmd w"
  execute "normal 120|"
  execute "normal zs"
  execute "windo setlocal scrollbind"
endfunction

function! ViewNormalLogRealign()
  execute "1 wincmd w"
  execute "normal 10|"
  execute "normal zs"
  execute "vert res 15"
  execute "2 wincmd w"
  execute "normal 26|"
  execute "normal zs"
  execute "vert res 25"
  execute "3 wincmd w"
  execute "normal 120|"
  execute "normal zs"
endfunction

"function! ScrollLog()
"  execute "normal zt"
"  let s:save_cursor = getpos(".")
"  let s:column = s:save_cursor[1]
"  let s:win_height = winheight(0)
"  let s:column = s:column + s:win_height
"  let s:save_cursor[1] = s:column
"  call setpos('.', s:save_cursor)
"  execute "normal zt"
"endfunction

function! ScrollLogDown()
  execute "normal <C-F>"
  execute "normal 0"
  execute "normal 120l"
  execute "normal zs"
endfunction"

function! ListFilesInThisDir()
  execute "0r !find ."
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

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
  execute "cs find " a:oper . " " . a:currword
  execute "copen"
  execute "wincmd k"
  execute "normal `Z"
  execute "set csqf="
endfunction

function! ExploreOnNewTab()
  execute "tabnew"
  execute "Explore ."
endfunction

function! Addspaces()
  let s:cmdName = input("Enter column:")
  execute "normal 50A "
  execute "normal " . s:cmdName ."|D"
  execute "normal A"
endfunction

" Zoom / Restore window.
function! ZoomToggle()
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()       
    resize vertical resize        
    let t:zoomed = 1   
  endif
endfunction

function! KeepOnlyWindowWithQuickFix()
  execute "only"
  execute "copen"
  execute "wincmd k"
endfunction

nnoremap <Leader>zoom <Esc>:call ZoomToggle()<CR>

" set mappings to go to a window
let i = 1
while i <= 9
  execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
  let i = i + 1
endwhile

"statusline
function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction

set laststatus=2


"my cscope.out is at a dir one level up!..so
if has("cscope") && filereadable("../cscope.out")
  cs add .. ..
endif
if filereadable("../tags")
  set tags+=../tags
endif

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

function! PanosTagsSink(line)
  let g:last_name = a:line
  call LoadCscopeToQuickFix(a:line,"s")
  execute "cc"
endfunction

function! PanosTags(file)
  call fzf#run({
  \   'source': "sed '/^\\!/d;s/\t.*//' " . a:file . " | uniq",
  \   'options' : '--exact',
  \   'right' : '30%',
  \   'sink':   function('PanosTagsSink')})
endfunction

function! PanosTagsSinkJustGo(line)
  let g:last_name = a:line
endfunction

function! PanosTagsJustGo(file)
  let g:last_name = ""
  call fzf#run({
  \   'source': "sed '/^\\!/d;s/\t.*//' " . a:file . " | uniq",
  \   'options' : '--exact',
  \   'right' : '30%',
  \   'sink':   function('PanosTagsSinkJustGo')})
  if !empty(g:last_name)
    execute ":redraw"
    echom "Working on " . g:last_name
    "call confirm("Press enter to continue.. There was just one result")
    execute ":cs f g " . g:last_name
  endif
endfunction

function! Test(last_name)
    execute ":cs f g " . a:last_name
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

function! OthersDesk()
  execute ":colorscheme default"
  execute ":set bg=dark"
endfunction

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

function! GotoTagLastName()
  execute "tag ".g:last_name
endfunction

nmap gS <Esc>:call MoveToDefintionOfMember(expand("<cword>"))<CR>
nmap gO <Esc>:call GotoTagLastName()<CR>

function! CheckSearch(word)
  echom "hi"
  execute "normal /\\<" . a:word . "\\>/s\<CR>"
endfunction

nmap \test <Esc>:call CheckSearch(expand("<cword>"))<CR>

nmap <Leader>fpanv  <Esc>:call PanosTags("../tags_v")<CR>
nmap <Leader>fpand  <Esc>:call PanosTags("../tags_d")<CR>


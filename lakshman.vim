nmap <special> <F8> :call ViewNormalLogRealign()<CR>

nmap ~nlog     <Esc>:call ViewNormalLog()<CR>
nmap ~nrea     <Esc>:call ViewNormalLogRealign()<CR>
nmap <Page-Down>  <Esc>:call ScrollLogDown()<CR>
nmap <Leader>fdd    <Esc>:call ListFilesInThisDir()<CR>
nmap <Leader>name        <Esc>:echo expand("%:p")<CR>
nmap ~nosyn       <Esc>:set syntax=<CR>
nmap <Leader>cmd         <Esc>:call GetCommandOutputOnNewTab()<CR>
nmap <Leader>mshed       <Esc>:call ShedM()<CR>
nmap <Leader>css         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"s")<CR>
nmap <Leader>csg         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"g")<CR>
nmap <Leader>csc         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"c")<CR>
nmap <Leader>adds        <Esc>:call Addspaces()<CR>
nmap <Leader>buf         <Esc>:call BufExplorer()<CR>
nmap <Leader>nerd        <Esc>:NERDTreeToggle<CR>
nmap <Leader>pas         <Esc>:set paste<CR>
nmap <Leader>nopas       <Esc>:set nopaste<CR>
nmap [w            <C-w>
nmap [h            <C-w>h
nmap [j            <C-w>j
nmap [k            <C-w>k
nmap [l            <C-w>l
nmap ]w            <C-w>
nmap ]h            <C-w>h
nmap ]j            <C-w>j
nmap ]k            <C-w>k
nmap ]l            <C-w>l
nmap <Leader>tc   <Esc>:tabclose<CR>
imap kj           <Esc>
cmap kj           <Esc>

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

nnoremap <Leader>zoom <Esc>:call ZoomToggle()<CR>



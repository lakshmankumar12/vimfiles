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
nmap Z            <Esc>:cclose<CR>
nmap gc           <Esc>:call KeepOnlyWindowWithQuickFix()<CR>
imap kj           <Esc>
cmap kj           <Esc>
nnoremap <Leader>pd   <Esc>:wincmd P<CR><C-D>:wincmd p<CR>
nnoremap <Leader>pu   <Esc>:wincmd P<CR><C-U>:wincmd p<CR>
nmap <Leader>ln   <C-w>h<Esc>:q<CR><C-w>P<C-n>
nmap <Leader>lp   <C-w>h<Esc>:q<CR><C-w>P<C-p>
nmap <Leader>hn   :q<CR><C-w>P<C-n>
nmap <Leader>hp   :q<CR><C-w>P<C-p>
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

function! GetMode()
  let l:m = mode()
  if l:m ==# "i"
    let mode = 'Insert'
  elseif l:m ==# "R"
    let mode = 'replace'
  elseif l:m =~# '\v(v|V||s|S|)'
    let mode = 'visual'
  else
    let mode = 'normal'
  endif
  return mode
endfunction

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusLineModeDisplay term=bold cterm=bold ctermfg=White ctermbg=Red
  elseif a:mode == 'r'
    hi statusLineModeDisplay term=bold cterm=bold ctermfg=White ctermbg=Yellow
  else
    hi statusLineModeDisplay term=bold cterm=bold ctermfg=White ctermbg=Cyan
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusLineModeDisplay term=bold cterm=bold ctermfg=Yellow ctermbg=Black

set laststatus=2
hi StatusLine term=bold cterm=bold ctermfg=Black ctermbg=White
hi statusLineModeDisplay term=bold cterm=bold ctermfg=Yellow ctermbg=Black
hi WindowNumber term=bold cterm=bold ctermfg=Yellow ctermbg=Black
"This is now set in ctags.vim
"set statusline=%F%h%m%r\ %h%w%y\ col:%c\ lin:%l\,%L\ buf:%n\ win:%{WindowNumber()}\ reg:%{v:register}\ %=%{TagName()}\ %-15.15(%l,%c%V%)%P

function! ListOfFilesOnLocationList()
  let s:cmdName = input("Enter command that will be loaded into location-list:")
  let old_makeprg=&makeprg
  let old_errorformat=&errorformat
  let &makeprg = s:cmdName
  let &errorformat="%f"
  lmake
  let &makeprg=old_makeprg
  let &errorformat=old_errorformat
endfunction


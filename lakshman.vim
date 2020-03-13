nmap <Leader>name        <Esc>:echo expand("%:p")<CR>
nmap <Leader>cmd         <Esc>:call GetCommandOutputOnNewTab()<CR>
nmap <Leader>mshed       <Esc>:call ShedM()<CR>
nmap <Leader>css         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"s")<CR>
nmap <Leader>csg         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"g")<CR>
nmap <Leader>csc         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"c")<CR>
nmap <Leader>adds        <Esc>:call Addspaces()<CR>
" Who uses ex mode these days!
nmap Q            <Esc>:tabclose\|tabprev<CR><Esc>
nmap gwx          <Esc>:tabclose<CR>
nmap zp           <Esc>:cclose<CR>:copen<CR>
" neither do i use S
nmap S            <Esc>
" Y is same yy. So, lets do something useful
nmap Y            y$:call DumpToClipBoard()<CR>
nmap gY           <Esc>:call KeepOnlyWindowWithLocationList()<CR>
nmap gll          <Esc>:FZF<CR>
nmap glb          <Esc>:FzfBuffers<CR>
nmap gl/          <Esc>:FzfBLines<CR>
nmap gww          <Esc>:update<CR>

nmap gO           <ESC>:AddressBar<CR>

"window movements
nmap gwh          <C-w>h
nmap gwj          <C-w>j
nmap gwk          <C-w>k
nmap gwl          <C-w>l
nmap gw=          <C-w>=
nmap gw\|         <C-w>\|
nmap gw_          <C-w>_
nmap gw<          <C-w><
nmap gw>          <C-w>>
nmap gwO          <Esc>:lclose<CR>
nmap gws          <C-w>s
nmap gwB          <Esc>:setlocal noexpandtab<CR>
nmap gwS          <Esc>:set spell!<CR>
nmap gwX          <Esc>:syntax sync fromstart<CR>
"these close other windows
nmap gwH          <C-w>h<C-w>c
nmap gwJ          <C-w>j<C-w>c
nmap gwK          <C-w>k<C-w>c
nmap gwL          <C-w>l<C-w>c
nmap gwo          <Plug>ZoomWin
nmap gwt          <Esc>mZ:tabnew %<CR>`Z
nmap gwg          <Esc>:GitGutterToggle<CR>
nmap gwn          <Esc>:set relativenumber!<CR>:set nu!<CR>
nmap gwr          <Esc>:set wrap!<CR>
nmap gwz          <Esc>:set list!<CR>
nmap gwd          <Esc>:diffoff<CR>
nnoremap gwa          <C-b>
nnoremap gwf          <C-f>
nnoremap gwm          <C-w>p
nnoremap <Leader>1  <Esc>: 1wincmd w<CR>
nnoremap <Leader>2  <Esc>: 2wincmd w<CR>
nnoremap <Leader>3  <Esc>: 3wincmd w<CR>
nnoremap <Leader>4  <Esc>: 4wincmd w<CR>
nnoremap <Leader>5  <Esc>: 5wincmd w<CR>
nnoremap <Leader>6  <Esc>: 6wincmd w<CR>
nnoremap <Leader>7  <Esc>: 7wincmd w<CR>

function! MyWinCmdWrapper(winnr)
    let l:cmd = a:winnr . "wincmd w"
    silent execute l:cmd
endfunction

nnoremap Z  :<C-U>call MyWinCmdWrapper(v:count)<CR>

function! MyWinCloseWrapper()
    if &buftype == 'quickfix'
        execute "close"
        return
    endif
    execute "normal mZ"
    execute "lclose"
    execute "close"
endfunction
nnoremap gwc          <Esc>:call MyWinCloseWrapper()<CR>

function! MyVsplitRightAndFocusThere()
    let l:my_id = win_getid()
    let l:loc_id = get(getloclist(0, {'winid':0}), 'winid', 0)
    if l:loc_id
        execute "lclose"
    endif
    execute "vsplit"
    let l:new_win_id = win_getid()
    if l:loc_id
        call win_gotoid(l:my_id)
        execute "lopen"
        call win_gotoid(l:new_win_id)
    endif
endfunction
nnoremap gwv          <Esc>:call MyVsplitRightAndFocusThere()<CR>

function! MyVsplitRightAndFocusBack()
    let l:my_id = win_getid()
    let l:loc_id = get(getloclist(0, {'winid':0}), 'winid', 0)
    if l:loc_id
        execute "lclose"
    endif
    execute "vsplit"
    let l:new_win_id = win_getid()
    call win_gotoid(l:my_id)
    if l:loc_id
        execute "lopen"
        call win_gotoid(l:my_id)
    endif
endfunction
nnoremap gwV          <Esc>:call MyVsplitRightAndFocusBack()<CR>

function! MyFixLocFixWrapper()
    if &buftype == 'quickfix'
        execute "ll"
    else
        execute "normal mZ"
    endif
    execute "lclose"
    execute "lopen"
    execute "ll"
endfunction

" i dont use ZZ/ZQ much. Anything else on Z?!
nnoremap gwN      <Esc>:call MyFixLocFixWrapper()<CR>

if has('nvim')
  nnoremap gwT        <Esc>:tabnew \| terminal<CR>
  nnoremap <M-t>      <Esc>:vsplit \| terminal<CR>
  nnoremap <M-s>      <Esc>:split  \| terminal<CR>
  nnoremap <M-r>      <Esc>:terminal<CR>

  tnoremap kj     <C-\><C-n>
  tnoremap <expr> <C-\><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  tnoremap <expr> <M-[> '<C-\><C-N>"'.nr2char(getchar()).'pi'

  " Terminal mode:
  tnoremap <M-h> <c-\><c-n>gT
  tnoremap <M-l> <c-\><c-n>gt

  inoremap <M-t>     <Esc>:vsplit \| terminal<CR>
  inoremap <M-s>     <Esc>:split  \| terminal<CR>

  autocmd BufWinEnter,WinEnter term://* startinsert
endif
nnoremap <M-h> gT
nnoremap <M-l> gt
inoremap <M-h> <Esc>gT
inoremap <M-l> <Esc>gt

"in insert mode, quickly come to next line w/o auto-formatting
inoremap <silent> <c-b> <esc>:set paste<cr>o<esc>:set nopaste<cr>a

"cscope'ish
nmap gxs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap gxg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap gxc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap gxS :vsplit<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap gxG :vsplit<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap gxC :vsplit<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>
nmap gxx <C-t>
nmap gxt <C-t>
nmap gxo <C-o>
nmap gxe :w! /tmp/gxeback<CR>:e!<CR>
nmap gxf <Esc>:FzfHistory<CR>
"Useful for magit like walking across hunks in a Gedit'ed commit display
nmap gxn :call SwitchBetweenDiffFolds('N')<CR>
nmap gxp :call SwitchBetweenDiffFolds('P')<CR>

nmap gyy          <Esc>:set paste!<CR>
nmap gB           <Esc>:FzfBuffers<CR>
nmap gz           <Esc>:ToggleBG<CR>
imap kj           <Esc>
cmap kj           <Esc>
imap jk           <Esc>
cmap jk           <Esc>
nmap gp           <Esc>p`[
nmap gP           <Esc>"+P
nmap gC           <Esc>:execute ":normal a" . system("tmux saveb -")<CR>
nmap gc           <Esc>:read !tmux saveb -<CR>
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

nmap <silent> <Plug>WinVertSizeIncrease <Esc>:vert resize +10<CR>:call repeat#set("\<Plug>WinVertSizeIncrease", v:count)<CR>
nmap gwP <Plug>WinVertSizeIncrease

nmap <silent> <Plug>WinVertSizeDecrease <Esc>:vert resize -10<CR>:call repeat#set("\<Plug>WinVertSizeDecrease", v:count)<CR>
nmap gwM <Plug>WinVertSizeDecrease

" ctrl-k to kill chars from current pos to eol in command mode only
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" visual mode add or remove chars in the chosen block
vnoremap - oh
vnoremap + ol

function! ChompedSystem( ...  )
  return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

" Take from: https://stackoverflow.com/a/4479072/2587153
function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
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

function! DuplicateCurrentBufferInANewScratchBufferInNewTab()
  if bufexists("lk_scratch")
        execute "bd! lk_scratch"
  endif
  let s:lnum = line(".")
  execute ":%y"
  let l:filetype = &l:filetype
  execute "tabnew lk_scratch"
  silent execute "normal p"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
  let &l:filetype = l:filetype
endfunction
nmap gwy         <Esc>:call DuplicateCurrentBufferInANewScratchBufferInNewTab()<CR>

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
  silent! execute "close"

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
  let s:cmd="!~/bin/prepare_tag_commands.py '" . expand("%:p") . "' > /tmp/cmds"
  execute s:cmd
  let s:cmd="!chmod +x /tmp/cmds"
  execute s:cmd
  let s:cmd="!/tmp/cmds"
  execute s:cmd
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

function! RemoveTrailWhite()
  execute ":%s/\\s\\+$//g"
endfunction

nmap gW <Esc>:call RemoveTrailWhite()<CR>

function! SearchCommandsTerm()
  execute "normal ? "
  let @/ = " "
endfunction

nmap gX <Esc>:call SearchCommandsTerm()<CR>


imap <c-x><c-l> <plug>(fzf-complete-line)

" Taken from vimagit
function! SwitchBetweenDiffFolds(dir)
  let back = ( a:dir == 'P' ) ? 'b' : ''
  let line = search("^@@ ", back . 'wn')
  if ( line != 0 )
    if ( foldlevel(line('.')) == 1 )
      try
        foldclose
      catch /^Vim\%((\a\+)\)\=:E490/
      endtry
    endif
    call cursor(line, 0)
    while ( foldclosed(line) != -1 )
      try
        foldopen
      catch /^Vim\%((\a\+)\)\=:E490/
        break
      endtry
    endwhile
  endif
endfunction


" functions
nmap gGG          <Esc>:call PanosTags("tags_f")<CR>
" struct/typedef
nmap gGS          <Esc>:call PanosTags("tags_s")<CR>
nmap gGT          <Esc>:call PanosTags("tags_s")<CR>
" member
nmap gGM          <Esc>:call PanosTags("tags_m")<CR>
" global variables
nmap gGV          <Esc>:call PanosTags("tags_v")<CR>
" defines/enums
nmap gGD          <Esc>:call PanosTags("tags_d")<CR>
nmap gGE          <Esc>:call PanosTags("tags_d")<CR>

function! PanosTagsSink(line)
  let s:cmdName = "a=" . a:line . "; echo ${a##*::}"
  let g:last_name = ChompedSystem(s:cmdName)
  call LoadCscopeToQuickFix(g:last_name,"s")
  execute "ll"
endfunction

function! PanosTags(file)
  call fzf#run({
  \   'source': "sed '/^\\!/d;s/\t.*//' " . a:file . " | uniq",
  \   'options' : '--exact',
  \   'right' : '30%',
  \   'sink':   function('PanosTagsSink')})
endfunction

function! GotoTagLastName()
  execute "tag ".g:last_name
endfunction

function! OpenArayakaFile(line)
    execute ":edit " . a:line
endfunction

"list_files_aryaka.sh is in quick_utility_scripts repo
function! AryakaFileOpen()
  call fzf#run({
  \   'source': "list_files_aryaka.sh",
  \   'options' : '--exact' ,
  \   'down'  : '20%',
  \   'sink':   function('OpenArayakaFile')})
endfunction
nmap gloo        <Esc>:call AryakaFileOpen()<CR>

if !exists("*ReloadConfigs")
  "The above safeguard is necessary as otherwise
  "  the function can't reload itself while in
  "  execution!
  function! ReloadConfigs()
    execute "source ~/.vimrc"
    execute "source ~/.vim/plugin/lakshman.vim"
    if filereadable("~/.vim/plugin/svn_lakshman.vim")
       echom "Reading svn too"
       execute "source ~/.vim/plugin/svn_lakshman.vim"
    endif
  endfunction
  command! Recfg call ReloadConfigs()
endif

let g:errorSearchTerm="error:"

function! LoadErrorsFunction(file)
  execute ":lclose"
  execute "normal mZ"
  execute ":lf " . a:file
  execute ":lopen"
  execute "wincmd k"
  execute "normal `Z"
  execute "wincmd j"
  execute "normal gg"
  execute "/" . g:errorSearchTerm
endfunction

function! LoadErrorsInAsnRoot()
    if !exists('g:currentRepoPrefix')
        SVNReset
    endif
    call LoadErrorsFunction(g:asnRootPrefix . "lakshman_make_op")
endfunction

command! -nargs=1 LE call LoadErrorsFunction(<f-args>)
command! LET call LoadErrorsFunction("~/tmp/errors")
command! LER call LoadErrorsInAsnRoot()

function! LoadListOfFilesFn(fileslist)
    let old_makeprg=&makeprg
    let old_errorformat=&errorformat
    let &makeprg = "cat " . a:fileslist
    let &errorformat="%f"
    echom &makeprg
    silent lmake
    let &makeprg=old_makeprg
    let &errorformat=old_errorformat
    execute "ll"
endfunction

command! -nargs=1 LoadListOfFiles call LoadListOfFilesFn(<f-args>)

au BufNewFile,BufRead *.applescript set filetype=applescript

function! IncreaseSizeOfPreviewFn()
    let l:n = winnr()            "note down where we were
    silent! wincmd P             "go to preview
    if &previewwindow            "if we really get there...
        exe "resize +2"
        "go back where we came from
        execute l:n . "wincmd w"
    endif
endfunction

function! DecreaseSizeOfPreviewFn()
    let l:n = winnr()            "note down where we were
    silent! wincmd P             "go to preview
    if &previewwindow            "if we really get there...
        exe "resize -2"
        "go back where we came from
        execute l:n . "wincmd w"
    endif
endfunction

function! ClosePreviewFn()
    let l:n = winnr()            "note down where we were
    silent! wincmd P             "go to preview
    if &previewwindow            "if we really get there...
        exe ":close"
        let l:n = l:n - 1
        "go back where we came from
        execute l:n . "wincmd w"
    endif
endfunction

function! ScrollUpInPreviewFn()
    let l:n = winnr()            "note down where we were
    silent! wincmd P             "go to preview
    if &previewwindow            "if we really get there...
        exe "normal! Lj"
        "go back where we came from
        execute l:n . "wincmd w"
    endif
endfunction

function! ScrollDownInPreviewFn()
    let l:n = winnr()            "note down where we were
    silent! wincmd P             "go to preview
    if &previewwindow            "if we really get there...
        exe "normal! Hk"
        "go back where we came from
        execute l:n . "wincmd w"
    endif
endfunction

nnoremap gyo <Esc>:exe "ptjump " . expand("<cword>")<Esc>
nnoremap gyx <Esc>:call ClosePreviewFn()<Esc>

nmap <silent> <Plug>IncreaseSizeOfPreview <Esc>:call IncreaseSizeOfPreviewFn()<CR>:call repeat#set("\<Plug>IncreaseSizeOfPreview", v:count)<CR>
nmap gyp <Plug>IncreaseSizeOfPreview

nmap <silent> <Plug>DecreaseSizeOfPreview <Esc>:call DecreaseSizeOfPreviewFn()<CR>:call repeat#set("\<Plug>DecreaseSizeOfPreview", v:count)<CR>
nmap gym <Plug>DecreaseSizeOfPreview

nmap <silent> <Plug>ScrollUpInPreview <Esc>:call ScrollUpInPreviewFn()<CR>:call repeat#set("\<Plug>ScrollUpInPreview", v:count)<CR>
nmap gyu <Plug>ScrollUpInPreview

nmap <silent> <Plug>ScrollDownInPreview <Esc>:call ScrollDownInPreviewFn()<CR>:call repeat#set("\<Plug>ScrollDownInPreview", v:count)<CR>
nmap gyd <Plug>ScrollDownInPreview

call textobj#user#plugin('datetime', {
\   'c_lang': {
\     'pattern': '\v[0-9a-zA-Z.\->_\[\]]+',
\     'select': ['ac', 'ic'],
\   },
\   'c_lang_op': {
\     'pattern': '\v[0-9a-zA-Z.\->_+*/()]+',
\     'select': ['ao', 'io'],
\   },
\   'generalpaths': {
\     'pattern': '\v[0-9a-zA-Z/_\-.<>(){}~]+',
\     'select': ['ax', 'ix'],
\   },
\ })

function! MakePlainAryakaFn(which, folder)
    execute "normal mZ"
    execute "lclose"
    let old_makeprg=&makeprg
    let &makeprg = 'sh -c "source /home/lakshman_narayanan/.bashrc.aryaka.centos.sh && go ' . a:folder . ' && ' . a:which . '"'
    echom &makeprg
    silent lmake
    let &makeprg=old_makeprg
    execute "lf /home/lakshman_narayanan/tmp/errors"
    execute "lopen"
    execute "wincmd p"
    execute "normal `Z"
    execute "ll"
endfunction

command! -nargs=* MakePlainAryaka call MakePlainAryakaFn(<f-args>)
nnoremap gMR <Esc>:MakePlainAryaka mkplain rse<CR>
nnoremap gMA <Esc>:MakePlainAryaka mkplain am<CR>
nnoremap gMT <Esc>:MakePlainAryaka mkplainpop tcp<CR>
nnoremap gMP <Esc>:MakePlainAryaka mkplainpop pss<CR>
nnoremap gMX <Esc>:MakePlainAryaka mkplain


function! LoadCurrPositions(...)
    let a:dontOpen = get(a:,1,"")
    if !exists("g:currLkPositionsFile")
        let g:currLkPositionsFile = "/tmp/vimPos." . getpid()
    endif
    execute "normal mZ"
    execute "lf " . g:currLkPositionsFile
    if empty(a:dontOpen)
        execute "lclose"
        execute "lopen"
        execute "wincmd p"
    endif
    execute "normal `Z"
endfunction

function! LoadCurrPositionsAndGoto(...)
    let a:position = get(a:,1,"")
    call LoadCurrPositions("dont")
    if empty(a:position)
        let l:position = 1
    else
        let l:position = a:position
    endif
    let l:cmd = l:position . "ll"
    silent execute l:cmd
endfunction

function! GotoCurrentLocationListItem()
    let @z="UnsetZRegisterBeforeSearch"
    execute "wincmd j"
    execute 'normal 02f>ll"zy$'
    execute "wincmd k"
    let @/="\\V" . @z
    execute "normal n"
endfunction

function! ReplaceACurrentPosition()
    "Execute this after you :ll on the position to change
    "And be on the main-window
    let g:currLkPositionsFile = "/tmp/vimPos." . getpid()
    let l:currLine = line(".")
    let l:cmd = "sed '" . l:currLine . "q;d' " . expand("%") . " | tr -d '\n' "
    let l:line = system(l:cmd)
    let l:line = substitute(l:line, '"', '\\"', "g")
    let l:origName = expand("%")
    execute "wincmd j"
    let @z="UnsetZRegisterBeforeSearch"
    execute 'normal 02f>ll"zy$'
    let l:replLine = line(".")
    let l:cmd = "sed -n -e 's/.*<<\\(.*\\)>>.*$/\\1/' -e '" . l:replLine . "p' " . g:currLkPositionsFile
    let l:name = system(l:cmd)
    let l:name = substitute(l:name, '\n\+$', '', '')
    let l:cmd = "sed -e '" . l:replLine . "d' -i " . g:currLkPositionsFile
    let l:discard = system(l:cmd)
    let l:final = l:origName . ":" . l:currLine . ": <<" . l:name . ">> " . l:line
    if l:replLine == "1"
        let l:cmd = 'sed -e "' . l:replLine . "i " . l:final . '" -i ' . g:currLkPositionsFile
    else
        " actually .i. on all lines will work except for last line.
        " But dont know how to check for last line in vim. So using i only for
        " 1st line and using a on all other lines by going behind one line
        let l:replLine = l:replLine - 1
        let l:cmd = 'sed -e "' . l:replLine . "a " . l:final . '" -i ' . g:currLkPositionsFile
        let l:replLine = l:replLine + 1
    endif
    let l:line = system(l:cmd)
    execute "wincmd k"
    call LoadCurrPositions()
    execute "normal " . l:replLine . "G"
    execute ":" . l:replLine . "ll"
endfunction


function! AddACurrentPosition()
    let g:currLkPositionsFile = "/tmp/vimPos." . getpid()
    let l:name = input('Enter name: ')
    let l:currLine = line(".")
    let l:cmd = "sed '" . l:currLine . "q;d' " . expand("%") . " | tr -d '\n' "
    let l:line = system(l:cmd)
    let l:final = expand("%") . ":" . l:currLine . ": <<" . l:name . ">> " . l:line
    let l:cmd = 'echo ' . shellescape(l:final) . ' >> ' . g:currLkPositionsFile
    let l:line = system(l:cmd)
    call LoadCurrPositions()
    execute "normal G"
    let l:replLine = line(".")
    execute ":" . l:replLine . "ll"
endfunction

function! ZapCurrentPosition()
    " Call this from location list window!
    execute "wincmd k"
    execute "normal mZ"
    execute "wincmd j"
    let l:replLine = line(".")
    let l:cmd = "sed -e '" . l:replLine . "d' -i " . g:currLkPositionsFile
    let l:line = system(l:cmd)
    execute "lf " . g:currLkPositionsFile
    execute "normal " . l:replLine . "G"
    execute "wincmd k"
    execute "normal `Z"
    execute "wincmd j"
endfunction


function! EditCurrPositions()
    execute "edit " . g:currLkPositionsFile
endfunction

nnoremap gya <Esc>:call AddACurrentPosition()<CR>
nnoremap gyl <Esc>:call LoadCurrPositions()<CR>
nnoremap gye <Esc>:call EditCurrPositions()<CR>
nnoremap gyr <Esc>:call ReplaceACurrentPosition()<CR>
nnoremap gys <Esc>:call GotoCurrentLocationListItem()<CR>
nnoremap gyz <Esc>:call ZapCurrentPosition()<CR>
nnoremap gyt <Esc>:lclose\|Toc<CR>
nnoremap gyg :<C-U>call LoadCurrPositionsAndGoto(v:count)<CR>

function! GitGrepFn(stayInLoc,encloseword,ignoreCase,grepArg,...)
    execute "normal mZ"
    let l:pathSpecArg = get(a:,1,"")
    let l:cmd = "lgrep! --no-pager grep -nH "
    if a:ignoreCase
        let l:cmd = l:cmd . "-i "
    endif
    let l:cmd = l:cmd . "'"
    if a:encloseword
        let l:cmd = l:cmd . '\b'
    endif
    let l:cmd = l:cmd . a:grepArg
    if a:encloseword
        let l:cmd = l:cmd . '\b'
    endif
    let l:cmd = l:cmd . "'"
    if !empty(l:pathSpecArg)
        let l:cmd = l:cmd . " -- '*" . l:pathSpecArg . "*'"
    endif
    echom "cmd is:" . l:cmd
    let old_grepprg=&grepprg
    let &grepprg = "git"
    let old_grepprg=&grepprg
    silent! execute l:cmd
    let &grepprg=old_grepprg
    if len(getloclist(winnr()))
        execute "lopen"
        if !a:stayInLoc
            execute "ll"
        endif
    endif
endfunction
" Ggp -- base command
"   s -- stay in location-list window, dont go to item.
"   w -- enclose word
"   i -- ignore case
command! -nargs=+ Ggp call GitGrepFn(0,0,0,<f-args>)
command! -nargs=+ Ggps call GitGrepFn(1,0,0,<f-args>)
command! -nargs=+ Ggpw call GitGrepFn(0,1,0,<f-args>)
command! -nargs=+ Ggpi call GitGrepFn(0,0,1,<f-args>)

command! -nargs=+ Ggpsw call GitGrepFn(1,1,0,<f-args>)
command! -nargs=+ Ggpsi call GitGrepFn(1,0,1,<f-args>)
command! -nargs=+ Ggpwi call GitGrepFn(0,1,1,<f-args>)

command! -nargs=+ Ggpswi call GitGrepFn(1,1,1,<f-args>)

nnoremap gwii <Esc>:<C-U>Ggp
nnoremap gwic <Esc>:<C-U>Ggp expand("<cword>")
nnoremap gwir <Esc>:<C-U>Ggp /rse/<Left><Left><Left><Left><Left><Left>

" use the vimgrepperutil.sh in quick-utils repo.
"   grep <pattern> <pattern-to-filter-files> <file-with-filenames>
function! FileGrepper(stayInLoc,encloseword,ignoreCase,grepArg,pathSpecArg,fileArg)
    execute "normal mZ"
    let l:cmd = a:pathSpecArg . " " . a:fileArg . " "
    if a:ignoreCase
        let l:cmd = l:cmd . "-i "
    endif
    let l:grepPat = "'"
    if a:encloseword
        let l:grepPat = l:grepPat . '\b'
    endif
    let l:grepPat = l:grepPat . a:grepArg
    if a:encloseword
        let l:grepPat = l:grepPat . '\b'
    endif
    let l:grepPat = l:grepPat . "'"
    let l:cmd = "lgrep! " . l:grepPat . " " . l:cmd
    echom "cmd is:" . l:cmd
    let old_grepprg=&grepprg
    let &grepprg = "vimgrepperutil.sh"
    let old_grepprg=&grepprg
    silent! execute l:cmd
    let &grepprg=old_grepprg
    if len(getloclist(winnr()))
        execute "lopen"
        if !a:stayInLoc
            execute "ll"
        endif
    endif
endfunction

command! -nargs=+ Ggf call FileGrepper(0,0,0,<f-args>)
nnoremap gwif <Esc>:<C-U>Ggf

function! StripColorCodes()
    execute "%s/\\\\033.\\{-}m//g"
endfunction

function! CompileTestCaseFile()
    let l:cmd="!" . $HOME . "/github/TestCaseExpander/TestCaseExpander.py -w " . expand("%:p") . " -o  " . expand("%:p:r") .  ".out.tdef"
    execute l:cmd
endfunction

nnoremap zFjj <Esc>:tabnew ~/tmp/jira_comment<CR>
nnoremap zJcc <Esc>:tabnew ~/tmp/jira_comment<CR>
nnoremap zFcc <Esc>:tabnew ~/tmp/commit_comment<CR>
nnoremap zFrr <Esc>:tabnew ~/tmp/review_description<CR>

"Replaces current window with newly downloaded jira-op
function! JiraGetInFile(jiraid)
    let l:cmd="download_jira.py -o jira-op " . a:jiraid
    echom l:cmd
    let l:discard = system(l:cmd)
    execute "e jira-op"
    normal /\V\^********   Changelog/
endfunction
nnoremap zJff <Esc>:<C-U>call JiraGetInFile(expand("<cWORD>"))<CR>

function! JiraGetInBuffer(jira_id)
    if expand("%") ==? "jira_scratch"
        execute "%d"
    else
        if bufexists("jira_scratch")
            execute "bd! jira_scratch"
        endif
        execute "tabnew jira_scratch"
        execute "%d"
    endif
    let l:cmd="download_jira.py " . a:jira_id
    echom l:cmd
    silent execute "0r !" . l:cmd
    set nomodified
    setlocal bufhidden=hide
    setlocal noswapfile
    let &l:filetype = "jira_op"
    normal /\V\^********   Changelog/
endfunction
nnoremap zJss  <Esc>:<C-U>call JiraGetInBuffer(expand("<cWORD>"))<CR>

function! AskAndOpenJiraInFile()
  let l:jira_id = input("Enter Jira-ID:", "ASN-")
  call JiraGetInFile(l:jira_id)
endfunction
nnoremap zJaf <Esc>:<C-U>call AskAndOpenJiraInFile()<CR>

function! AskAndOpenJiraInBuffer()
  let l:jira_id = input("Enter Jira-ID:", "ASN-")
  call JiraGetInBuffer(l:jira_id)
endfunction
nnoremap zJas <Esc>:<C-U>call AskAndOpenJiraInBuffer()<CR>

function! JiraRefreshCurrentFile()
    let l:jiraid=getline(1)
    call JiraGetInFile(l:jiraid)
endfunction
nnoremap zJrf <Esc>:<C-U>call JiraRefreshCurrentFile()<CR>

function! JiraRefreshCurrentBuffer()
    let l:jiraid=getline(1)
    call JiraGetInBuffer(l:jiraid)
endfunction
nnoremap zJrs <Esc>:<C-U>call JiraRefreshCurrentBuffer()<CR>

function! RefreshJiraList()
    let l:cmd="list_issues.py -s > jira.new"
    let l:discard = system(l:cmd)
    silent execute "only"
    silent execute "e A_jira_list"
    silent execute "normal gg"
    silent execute "split jira.new"
    let l:cmd="python3 /home/lakshman_narayanan/gitlab/aryaka-scripts/jira/compare_jira_lists.py A_jira_list jira.new"
    silent execute "0r !" . l:cmd
    silent execute "w"
endfunction
nnoremap zJll <Esc>:<C-U>call RefreshJiraList()<CR>

function! DownloadAttachmentInBuffer()
    let l:jiraid=getline(1)
    let l:attachinfo=getline('.')
    let l:attachinfoparts=split(l:attachinfo, ":")
    let l:filename=l:attachinfoparts[1]
    let l:filename=Strip(l:filename)
    let l:attachid=l:attachinfoparts[2]
    let l:attachid=Strip(l:attachid)
    if bufexists(l:filename)
        echom "Sorry.. " . l:filename " buffer exists. Close that and re-issue"
        return
    endif
    execute "tabnew " . l:filename
    silent execute "%d"
    let l:cmd="/home/lakshman_narayanan/gitlab/aryaka-scripts/jira/download_jira.py -A " . l:attachid . " " . l:jiraid
    silent execute "0r !" . l:cmd
    silent execute "0r !echo " . l:cmd
    set nomodified
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction
nnoremap zJds <Esc>:<C-U>call DownloadAttachmentInBuffer()<CR>


" DONT TYPE ANYTHING HERE SO THAT CENTOS-BRANCH CAN
" SAFELY ADD ITS OVERRIDES WITHOUT ISSUES





" ***********


cmap bke<CR> :call DoBKEdit(expand("%"))<CR>
cmap bka<CR> :call DoBKAnnotate(expand("%"))<CR>
cmap bkra<CR> :call DoBKRevAnnotate()<CR>
cmap bkl<CR> :call DoBKLog(expand("%"))<CR>
cmap bks<CR> :call ShowBKSfiles()<CR>
cmap bkd<CR> :call ShowBKDiff(expand("%"))<CR>
cmap bkrd<CR> :call DoBKRevDiff(expand("<cWORD>"))<CR>
cmap bkfd<CR> :call ShowBKFileDiff(expand("<cfile>"))<CR>
cmap bkc<CR> :call ShowBKChange()<CR>
cmap bkrs<CR> :call ShowBKRset(expand("<cWORD>"))<CR>
cmap bkrfd<CR> :call ShowBKRsetFileDiff(expand("<cWORD>"))<CR>

function! DoBKEdit(filename)
  setlocal autoread 
  silent execute "!bk edit " . a:filename
  redraw!
endfunction

function! DoBKAnnotate(filename)
  if bufexists("annotate")
        execute "bd! annotate"
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  execute "new annotate"
  let s:cmdName = "bk annotate -Adur " . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer annotate"
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction

function! DoBKRevAnnotate()
  if bufexists("annotate")
        execute "bd! annotate"
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  let s:cmdOpt = input("Enter Revision number:")
  execute "new annotate"
  let s:cmdName = "bk annotate -Adur -r" . s:cmdOpt . " " . g:currentLoggedFile
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer annotate"
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction

function! DoBKLog(filename)
  execute "tabnew " . expand("%:p") . "_log"
  let g:currentLoggedFile = a:filename
  let s:cmdName = "bk log " . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

function! DoBKRevDiff(revision)
  let s:parent_rev = system("bk diffs -u -R" . a:revision . " " . g:currentLoggedFile . " | head -1 | awk ' { print $3 } ' ")
  let s:parent_rev = substitute(s:parent_rev, '\s*\n\s*', '', '')
  let s:pfile = "tmpfile" 
  let s:cmdName = "bk get -p -r" . s:parent_rev . " " . g:currentLoggedFile . " > " . s:pfile
  silent execute system(s:cmdName)
  let s:pfile2 = "tmpfile2" 
  let s:cmdName = "bk get -p -r" . a:revision . " " . g:currentLoggedFile . " > " . s:pfile2
  silent execute system(s:cmdName)
  execute "tabnew " . a:revision
  execute "0r " . s:pfile2
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "vnew " . s:parent_rev
  execute "0r " . s:pfile
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "diffthis"
  execute "wincmd l"
  execute "diffthis"
  execute "normal 1G"
endfunction

function! ShowBKRset(revno)
  if bufexists("rset")
        execute "bd! rset"
  endif
  execute "new rset"
  if stridx(a:revno,"ChangeSet@") >= 0
          let s:tmp = substitute(a:revno,"ChangeSet@","","")
          let s:revno = substitute(s:tmp,",","","")
  endif
  let s:cmdName = "bk rset -a -r" . s:revno
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer rset"
  execute "normal 1G"
endfunction

function! ShowBKChange()
  if bufexists("changes")
          execute "bd! changes"
  endif
  execute "new changes"
  let s:cmdName = "bk changes " 
  echohl Keyword
  let s:cmdOpt = input("Enter \"bk changes \" options : ","-n -u" . $USER . " -c-3M")
  echohl None
  let s:cmdName .= s:cmdOpt
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer changes"
  execute "normal 1G"
endfunction

function! ShowBKSfiles()
  if bufexists("sfiles")
          execute "bd! sfiles"
  endif
  execute "new sfiles"
  let s:cmdName = "bk sfiles -cg" 
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer sfiles"
  execute "normal 1G"
endfunction

function! ShowBKDiff(filename)
  let s:fileType = &ft
  let s:ftail = expand("%:t")
  let s:ftail = "__" . s:ftail
  execute "tabnew " . a:filename
  execute "WMClose"
  if bufexists(s:ftail)
          execute "bd! " . s:ftail
  endif
  execute "vnew " . s:ftail
  execute "wincmd x"
  execute "wincmd l"
  let s:cmdName = "bk get -p " . a:filename
  silent execute "0r !" . s:cmdName
  execute "set filetype=" . s:fileType
  execute "normal G-1"
  execute "normal dG"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "diffthis"
  execute "wincmd h"
  execute "diffthis"
  execute "normal 1G"
endfunction

function! ShowBKFileDiff(filename)
  execute "tabnew " . a:filename
  silent execute "call ShowBKDiff(expand(\"%\"))"
endfunction

function! ShowBKRsetFileDiff(fileline)
  let filelst = split(a:fileline,'|')
  let filedir = split(filelst[0],'/')
  let verlst = split(filelst[1],'\.\.')
  let tailidx = len(filedir) - 1
  let s:cmdName = "__" . filedir[tailidx] 
  let s:cmdName .= "@"
  let s:cmdName .= verlst[0]
  if bufexists(s:cmdName)
    execute "bd! " . s:cmdName
  endif
  silent execute "tabnew " . s:cmdName 
	silent execute "0r !bk get -p -r" . verlst[0] . " " . filelst[0]
	execute "set filetype=c"
  execute "normal G-1"
  execute "normal dG"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let s:cmdName = "__" . filedir[tailidx] 
  let s:cmdName .= "@"
  let s:cmdName .= verlst[1]
  if bufexists(s:cmdName)
    execute "bd! " . s:cmdName
  endif
	silent execute "vnew " . s:cmdName 
	silent execute "0r !bk get -p -r" . verlst[1] . " " . filelst[0]
	execute "set filetype=c"
  execute "normal G-1"
  execute "normal dG"
	set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  execute "diffthis"
  execute "wincmd l"
  execute "diffthis"
  execute "wincmd h"
  execute "normal 1G"
endfunction


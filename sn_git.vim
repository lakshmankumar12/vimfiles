"What i use:
cmap gitb<CR> :call DoGitBlame(expand("%"))<CR>
cmap gitl<CR> :call DoGitLog(expand("%"))<CR>
cmap gitd<CR> :call ShowGitCurrDiff(expand("%"))<CR>
cmap gitdr<CR> :call ShowGitCurrRevDiff(expand("%"))<CR>
cmap gitrd<CR> :call ShowGitRevDiff(expand("<cWORD>"))<CR>
cmap gitc<CR> :call DoGitRevCommitFiles(expand("<cWORD>"))<CR>
cmap gitshow<CR> :call DoGitShowStatus()<CR>
cmap gitset<CR> :call DoGitSetStatus()<CR>
cmap gitrb<CR> :call DoGitRevBlame()<CR>
"I make typo's often .. so let all freq combos too be the same!
cmap gitrcd<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 
cmap gitrdc<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 
cmap gitcdr<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 

function! DoGitBlame(filename)
  if bufexists("annotate")
        execute "bd! annotate"
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  execute "new annotate"
  let s:cmdName = "git blame " . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer annotate"
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction

function! DoGitRevBlame()
  let s:rev = input("Enter revision:")
  let s:buf_name = g:currentLoggedFile . "_" . s:rev . "_blame"
  if bufexists(s:buf_name)
        execute "bd! " . s:buf_name
  endif
  execute "tabnew " . s:buf_name
  let s:cmdName = "git blame " . s:rev . " " . g:currentLoggedFile
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

function! DoGitLog(filename)
  execute "tabnew " . expand("%:p") . "_log"
  let g:currentLoggedFile = a:filename
  let s:cmdName = "git log " . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

function! ShowGitCurrDiff(filename)
  let s:fileType = &ft
  let s:ftail = expand("%:t")
  let s:ftail = "__" . s:ftail
  execute "tabnew " . a:filename
  if bufexists(s:ftail)
          execute "bd! " . s:ftail
  endif
  execute "vnew " . s:ftail
  let s:cmdName = "git show HEAD:" . a:filename
  silent execute "0r !" . s:cmdName
  execute "set filetype=" . s:fileType
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"
  execute "wincmd l"
  execute ":diffthis"
  execute "normal 1G"
  execute "normal zR"
  execute "normal ]c"
endfunction

function!  ShowGitCurrRevDiff(filename)
  let s:rev = input("Enter revision:")
  let s:fileType = &ft
  let s:ftail = expand("%:t")
  let s:ftail = "__" . s:ftail
  execute "tabnew " . a:filename
  if bufexists(s:ftail)
          execute "bd! " . s:ftail
  endif
  execute "vnew " . s:ftail
  let s:cmdName = "git show " . s:rev . ":" . a:filename
  silent execute "0r !" . s:cmdName
  execute "set filetype=" . s:fileType
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"
  execute "wincmd l"
  execute ":diffthis"
  execute "normal 1G"
  execute "normal zR"
  execute "normal ]c"
endfunction

function! ShowGitRevDiffFiles(filename, rev1, rev2)
  let s:rev1_name = a:filename . "_" . a:rev1
  let s:rev2_name = a:filename . "_" . a:rev2
  if bufexists(s:rev1_name)
          execute "bd! " . s:rev1_name
  endif
  if bufexists(s:rev2_name)
          execute "bd! " . s:rev2_name
  endif
  execute "tabnew " . s:rev2_name
  let s:cmdName = "git show " . a:rev2 . ":" . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "vnew " . s:rev1_name
  let s:cmdName = "git show " . a:rev1 . ":" . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"
  execute "wincmd l"
  execute ":diffthis"
  execute "normal 1G"
  execute "normal zR"
  execute "normal ]c"
endfunction

function! ShowGitRevDiff(revision)
  let g:currentRevision = a:revision
  let s:cmdName = "git show --quiet --pretty=format:\"%P\" " . a:revision
  let s:parent_rev = system(s:cmdName)
  call ShowGitRevDiffFiles(g:currentLoggedFile,s:parent_rev,a:revision)
endfunction

function! DoGitRevCommitFiles(revision)
  let g:currentRevision = a:revision
  if bufexists("commit_files")
        execute "bd! commit_files"
  endif
  execute "vnew cset_files"
  silent execute "0r !git diff-tree --no-commit-id --name-only -r " . a:revision
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

function! DoGitShowStatus()
  let s:a = "Current file: " . g:currentLoggedFile
  echo s:a
  let s:a = "Current Revision: " . g:currentRevision
  echo s:a
endfunction

function! DoGitSetStatus()
  let s:rev = input("Enter revision:")
  let g:currentRevision = s:rev
endfunction

function! DoGitCsetRevDiff(other_file)
  let s:cmdName = "git show --quiet --pretty=format:\"%P\" " . g:currentRevision
  let s:parent_rev = system(s:cmdName)
  call ShowGitRevDiffFiles(a:other_file,s:parent_rev,g:currentRevision)
endfunction


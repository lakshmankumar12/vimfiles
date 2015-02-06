"What i use:
cmap cvsd<CR> :call ShowCvsCurrDiff(expand("%"))<CR>
cmap cvsa<CR> :call DoCvsAnnotate(expand("%"))<CR>
cmap cvslr<CR> :call DoCvsLogRevision(expand("<cWORD>"))<CR>

"cmap gitrd<CR> :call ShowGitRevDiff(expand("<cWORD>"))<CR>
"cmap gitc<CR> :call DoGitRevCommitFiles(expand("<cWORD>"))<CR>
"cmap gitshow<CR> :call DoGitShowStatus()<CR>
"cmap gitset<CR> :call DoGitSetStatus()<CR>
"cmap gitrb<CR> :call DoGitRevBlame()<CR>

""I make typo's often .. so let all freq combos too be the same!
"cmap gitrcd<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 
"cmap gitrdc<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 
"cmap gitcdr<CR> :call DoGitCsetRevDiff(expand("<cWORD>"))<CR> 

function! ShowCvsCurrDiff(filename)
  let s:fileType = &ft
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let s:temp_name = "__" . s:filename_t
  execute "tabnew " . a:filename
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  execute "vnew " . s:temp_name
  let s:cmdName = "grep '\\<" . s:filename_t . "\\>' " . s:filename_h . "/CVS/Entries | awk -F/ '{print $3}'"
  let s:file_rev = system(s:cmdName)
  let s:file_rev = substitute(s:file_rev, '^\s*\(.\{-}\)\s*\n*$', '\1', '')
  let s:cmdName = "cvs checkout -p -r" . s:file_rev . " " . s:filename_h . "/" . s:filename_t
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

function! DoCvsAnnotate(filename)
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let g:currentLoggedFile = s:filename_h . "/" . s:filename_t
  if bufexists("annotate")
        execute "bd! annotate"
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  execute "new annotate"
  let s:cmdName = "grep '\\<" . s:filename_t . "\\>' " . s:filename_h . "/CVS/Entries | awk -F/ '{print $3}'"
  let s:file_rev = system(s:cmdName)
  let s:file_rev = substitute(s:file_rev, '^\s*\(.\{-}\)\s*\n*$', '\1', '')
  let s:cmdName = "cvs annotate -r" . s:file_rev ." " . g:currentLoggedFile
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer annotate"
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction


function! DoCvsLogRevision(revision)
  execute "tabnew " . g:currentLoggedFile . "_log"
  let s:cmdName = "cvs log -r" . a:revision . "-N " . g:currentLoggedFile
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

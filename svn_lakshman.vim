"What i use:
com! SVNDiff  call ShowSvnCurrDiff(expand("%:p"))
com! SVNAnno  call DoSvnAnnotate(expand("%:p"))
com! SVNRev   call DoSvnLogRevision(expand("<cWORD>"))
com! SVNRDiff call ShowSvnRevDiff(expand("<cWORD>"))

function! ChompedSystem( ...  )
  return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

function! ShowSvnCurrDiff(filename)
  let g:currentLoggedSVNFile = a:filename
  let s:fileType = &ft
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let s:temp_name = "__" . s:filename_t
  execute "tabnew " . a:filename
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  execute "vnew " . s:temp_name
  let s:cmdName = "svn cat -rBASE " . a:filename
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
  " Lets save our URL prepend for later use
  let s:cmdName = "svn info " . a:filename . " | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
  let g:currentRepoPrefix = ChompedSystem(s:cmdName)
endfunction

function! DoSvnAnnotate(filename)
  let g:currentLoggedSVNFile = a:filename
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let s:temp_name = "__anno__" . s:filename_t
  execute "tabnew " . a:filename
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  setlocal scrollbind
  let s:size = winwidth(0) * 1/4
  execute "vsplit " . s:temp_name
  execute "vert resize " . s:size
  let s:cmdName = "svn info " . a:filename . " | grep Path: | cut -d' ' -f2"
  let s:repoName = system(s:cmdName)
  let s:cmdName = "svn annotate " . s:repoName
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal scrollbind
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
  " Lets save our URL prepend for later use
  let s:cmdName = "svn info " . a:filename . " | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
  let g:currentRepoPrefix = ChompedSystem(s:cmdName)
endfunction


function! DoSvnLogRevision(revision)
  let g:currentLoggedSVNRev = a:revision
  let s:temp_name = "_rev_" . a:revision
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn log --verbose -r" . a:revision
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

function! ShowSvnRevDiff(filename)
  " step-1: Get the left side revision number
  let s:cmdName = "echo " . a:filename . " | sed 's#^/[^/]*/[^/]*/##'"
  let s:svn_file_arg_latter = ChompedSystem(s:cmdName)
  let s:svn_file_arg = g:currentRepoPrefix . s:svn_file_arg_latter
  let s:cmdName = "svn diff -c" . g:currentLoggedSVNRev . " " . s:svn_file_arg . " > /tmp/svn_plugin.patch"
  call system(s:cmdName)
  let s:cmdName = "head -n 3 /tmp/svn_plugin.patch | grep -E -o 'revision [[:digit:]]+' | cut -d' ' -f2"
  let s:left_rev = ChompedSystem(s:cmdName)
  let s:cmdName = "svn info -r" . s:left_rev . " " . s:svn_file_arg . " | grep 'Last Changed Rev:' | cut -d' ' -f4"
  let s:left_rev = ChompedSystem(s:cmdName)

  "prepare names for buffers
  let s:right_rev = g:currentLoggedSVNRev
  let s:cmdName = "basename " . a:filename
  let s:small_name = system(s:cmdName)
  let s:file_name_t = system(s:cmdName)
  let s:lbuf_name = "__" . s:left_rev . "_" . s:small_name
  let s:rbuf_name = "__" . s:right_rev . "_" . s:small_name

  "show the 2 revisions
  if bufexists(s:lbuf_name)
          execute "bd! " . s:lbuf_name
  endif
  if bufexists(s:rbuf_name)
          execute "bd! " . s:rbuf_name
  endif
  execute "tabnew " . s:rbuf_name
  let s:cmdName = "svn cat -r" . s:right_rev . " " . s:svn_file_arg
  silent execute "%d"
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"

  execute "vnew " . s:lbuf_name
  let s:cmdName = "svn cat -r" . s:left_rev . " " . s:svn_file_arg
  silent execute "%d"
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"

  execute "wincmd l"
  execute "normal 1G"
  execute "normal zR"
  execute "normal ]c"
  execute "normal zz"
endfunction


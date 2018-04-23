"What i use:
com! SVNDiff   call ShowSvnCurrDiff(expand("%:p"))
com! SVNAnno   call DoSvnAnnotate(expand("%:p"))
com! SVNRev    call DoSvnLogRevision(expand("<cWORD>"))
com! SVNRDiff  call ShowSvnRevDiff(expand("<cWORD>"))
com! SVNStatus call ShowSvnStatus()
com! -nargs=* SVNLog  call ShowSvnLog(<f-args>)
com! SVNedited call ShowSVNFiles()

function! ShowSvnCurrDiff(filename)
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
  execute "setlocal filetype=" . s:fileType
  setlocal nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":diffthis"
  silent exec 'vertical resize '. string(&columns * 0.25)
  execute "wincmd l"
  execute ":diffthis"
  execute "normal 1G"
  execute "normal zR"
  execute "normal ]c"
  " Lets save our URL prepend for later use
  let s:cmdName = "svn info " . a:filename . " | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
  let g:currentRepoPrefix = ChompedSystem(s:cmdName)
endfunction

function! ShowSvnStatus()
  let s:temp_name = "__svn_status"
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn status"
  if filereadable ("./.branch_name")
    let s:branch = system("cat .branch_name")
    execute "lcd " . s:branch
  else
    0r "!echo no .branch file"
  endif
  silent execute "0r !" . s:cmdName
  setlocal nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute ":Clam svn diff"
  execute "normal gg"
  execute "wincmd h"
  execute "normal gg"
  silent execute ":MarkClear"
  silent execute ":Mark ^?"
  silent execute ":Mark ^M"
  silent execute "/^M"
  silent execute "normal w"
endfunction

nnoremap gwb :call ShowSvnCurrDiff(expand("<cWORD>"))<CR>

function! DoSvnAnnotate(filename)
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let s:temp_name = "__anno__" . s:filename_t
  let s:lnum = line(".")
  execute "tabnew " . a:filename
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  echom "Current line " s:lnum
  setlocal scrollbind
  let s:size = winwidth(0) * 1/4
  set nosplitright
  execute "vsplit " . s:temp_name
  set splitright
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
  let s:cmdName = "svn log --verbose -r" . a:revision . " " . g:currentRepoPrefix
  silent execute "0r !" . s:cmdName
  silent execute "0r !echo " . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

command! -nargs=1 SVNShowRev call DoSvnLogRevision(<f-args>)

function! ShowSvnRevDiff(filename)
  " step-1: Get the left side revision number
  let s:cmdName = "echo " . a:filename . " | sed 's#^/[^/]*/[^/]*/##'"
  let s:svn_file_arg_latter = ChompedSystem(s:cmdName)
  let s:svn_file_arg = g:currentRepoPrefix . "/" . s:svn_file_arg_latter
  let s:cmdName = "svn diff -c" . g:currentLoggedSVNRev . " " . s:svn_file_arg . " > /tmp/svn_plugin.patch"
  echom "command is " . s:cmdName
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

function! ShowSvnLog(...)
  let s:temp_name = "__svn_log"
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  if filereadable ("./.branch_name")
    let s:branch = system("cat .branch_name")
    execute "lcd " . s:branch
  else
    0r "!echo no .branch file"
  endif
  setlocal nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let l:num = ( a:0 >= 1 ) ? a:1 : 10
  echom "num is " . l:num
  execute ":Clam svn log -l " . l:num
  execute "wincmd l"
  let l:cmd = "%s/^r\\(\\d\\)/ \\1/"
  silent execute l:cmd
  if !exists('g:currentRepoPrefix')
    " Lets save our URL prepend for later use
    let s:cmdName = "svn info . | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
    let g:currentRepoPrefix = ChompedSystem(s:cmdName)
  endif
endfunction

" Gets a list of svn files - for now, what is edited
function! ShowSVNFiles()
    execute "tabnew %"
    let old_makeprg=&makeprg
    let old_errorformat=&errorformat
    let &makeprg = "svndiffjustfiles"
    let &errorformat="%f"
    echom &makeprg
    silent lmake
    let &makeprg=old_makeprg
    let &errorformat=old_errorformat
    execute "lopen"
    execute "ll"
    silent call ShowSvnCurrDiff(expand("%:p"))
endfunction

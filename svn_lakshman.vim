"What i use:
com! SVNDiff   call ShowSvnCurrDiff(expand("%:p"))
com! SVNAnno   call DoSvnAnnotate(expand("%:p"))
com! SVNRev    call DoSvnLogRevision(expand("<cWORD>"))
com! SVNRDiff  call ShowSvnRevDiff(expand("<cWORD>"))
com! SVNStatus call ShowSvnStatus()
com! -nargs=* SVNLog  call ShowSvnLog(<f-args>)
com! SVNEdited call ShowSVNFiles()
com! SVNAnnoParentRev call DoSvnAnnoRevision(g:currentLoggedSVNRevParentForFile)
com! -nargs=1 SVNAnnoShowRev call DoSvnAnnoRevision(<f-args>)
com! -nargs=1 SVNShowRev call DoSvnLogRevision(<f-args>)
com! -nargs=1 SVNShowRevOfFile call DoSvnDumpRevision(expand("%:p"),<f-args>)


" ALL globals
" g:currentRepoPrefix
" g:currentLoggedSVNRev
" g:currentLoggedFile
" g:currentLoggedSVNRevParentForFile

function! ShowSvnCurrDiff(filename)
  let s:fileType = &ft
  let s:filename_t = expand("%:t")
  let s:filename_h = expand("%:h")
  let s:temp_name = "__" . s:filename_t
  execute "tabnew " . a:filename
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  set nosplitright
  execute "vnew " . s:temp_name
  set splitright
  let s:cmdName = "svn cat -rBASE " . a:filename
  silent execute "0r !" . s:cmdName
  "delete the last line
  silent execute "$,$d"
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
    let s:branch = ChompedSystem("cat .branch_name")
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

function! DoSvnDumpRevision(filename, version)
  let s:lnum = line(".")
  let s:cmdName = "svn info " . a:filename . " | grep Path: | cut -d' ' -f2"
  let s:repoFileName = ChompedSystem(s:cmdName)
  let g:currentLoggedFile = s:repoFileName
  " Lets save our URL prepend for later use
  let s:cmdName = "svn info " . a:filename . " | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
  let g:currentRepoPrefix = ChompedSystem(s:cmdName)

  let s:cmdName = "basename " . s:repoFileName
  let s:small_name = ChompedSystem(s:cmdName)
  let s:temp_name = "__rev__" . a:version . "_" . s:small_name
  echom "Tempname is " . s:temp_name
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  silent execute "%d"
  let s:cmdName = "svn cat -r " . a:version . "  " . s:repoFileName
  silent execute "0r !" . s:cmdName
  silent execute "r !echo " . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction


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
  let s:cmdName = "svn info " . a:filename . " | grep '^Path:' | cut -d' ' -f2"
  let s:repoFileName = ChompedSystem(s:cmdName)
  let g:currentLoggedFile = s:repoFileName
  let s:cmdName = "svn annotate -v " . s:repoFileName
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

function! DoSVNRevWindowOpenRevDiff()
    let l:currentfile=expand("<cWORD>")
    execute "normal j"
    execute "normal 8|"
    silent call ShowSvnRevDiff(l:currentfile)
endfunction


function! DoSvnLogRevision(revision)
  if !exists('g:currentRepoPrefix')
      let s:cmdName = "svn info " . expand("%:p") . " | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
      let g:currentRepoPrefix = ChompedSystem(s:cmdName)
  endif
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
  nnoremap <buffer> gwb :call DoSVNRevWindowOpenRevDiff()<CR>
  execute "normal 5G"
  execute "normal 8|"
endfunction


function! ShowSvnRevDiff(filename)
  " step-1: Get the left side revision number
  let s:cmdName = "echo " . a:filename . " | sed 's#^/[^/]*/[^/]*/##'"
  let s:svn_file_arg_latter = ChompedSystem(s:cmdName)
  let s:svn_file_arg = g:currentRepoPrefix . "/" . s:svn_file_arg_latter
  let g:currentLoggedFile = s:svn_file_arg
  let s:cmdName = "svn diff -c" . g:currentLoggedSVNRev . " " . s:svn_file_arg . " > /tmp/svn_plugin.patch"
  echom "command is " . s:cmdName
  call ChompedSystem(s:cmdName)
  let s:cmdName = "head -n 3 /tmp/svn_plugin.patch | grep -E -o 'revision [[:digit:]]+' | cut -d' ' -f2"
  let s:left_rev = ChompedSystem(s:cmdName)
  let s:cmdName = "svn info -r" . s:left_rev . " " . s:svn_file_arg . " | grep 'Last Changed Rev:' | cut -d' ' -f4"
  let s:left_rev = ChompedSystem(s:cmdName)
  let g:currentLoggedSVNRevParentForFile = s:left_rev

  "prepare names for buffers
  let s:right_rev = g:currentLoggedSVNRev
  let s:cmdName = "basename " . a:filename
  let s:small_name = ChompedSystem(s:cmdName)
  let s:file_name_t = ChompedSystem(s:cmdName)
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

  set nosplitright
  execute "vnew " . s:lbuf_name
  set splitright
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
  execute "normal ]c"
  execute "normal zz"
endfunction

function! DoSvnAnnoRevision(revision)
  let s:cmdName = "svn info " . expand("%:p") . " | grep Path: | cut -d' ' -f2"
  let l:filename = ChompedSystem(s:cmdName)
  let s:temp_name = "_rev_" . a:revision . "_" . fnamemodify(l:filename, ':t')
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  echom "bufname is set to " . s:temp_name
  let s:temp_anno_name = s:temp_name . "_anno"
  echom "annoname is set to " . s:temp_anno_name
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn cat -r" . a:revision . " " . l:filename
  silent execute "0r !" . s:cmdName
  silent execute "0r !echo " . s:cmdName
  echom "cmd is " . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  if bufexists(s:temp_anno_name)
          execute "bd! " . s:temp_anno_name
  endif

  setlocal scrollbind
  let s:size = winwidth(0) * 1/4
  set nosplitright
  execute "vsplit " . s:temp_anno_name
  set splitright
  execute "vert resize " . s:size

  let s:cmdName = "svn annotate -v -r" . a:revision . " " . l:filename
  silent execute "0r !" . s:cmdName
  silent execute "0r !echo " . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal scrollbind

  silent execute "wincmd l"
endfunction


function! ShowSvnLog(...)
  let s:temp_name = "__svn_log"
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  if filereadable ("./.branch_name")
    let s:branch = ChompedSystem("cat .branch_name")
    execute "lcd " . s:branch
  else
    0r "!echo no .branch file"
  endif
  setlocal nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let l:num = ( a:0 >= 1 ) ? a:1 : 100
  echom "num is " . l:num
  execute ":0r !svn log -l " . l:num
  execute "wincmd l"
  let l:cmd = "%s/^r\\(\\d\\)/ \\1/"
  silent execute l:cmd
  if !exists('g:currentRepoPrefix')
    " Lets save our URL prepend for later use
    let s:cmdName = "svn info . | grep URL: | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
    let g:currentRepoPrefix = ChompedSystem(s:cmdName)
  endif
  execute "normal gg"
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
    silent call ShowSvnCurrDiff(expand("<cWORD>"))
endfunction

function! GetRevOfFile(rev)
endfunction

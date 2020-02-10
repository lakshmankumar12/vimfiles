"What i use:
"
" Checked what's edited in current file                      | SVNDiff
" Check what's edited across all files                       | SVNEdited
"
" Annotate the current file                                  | SVNAnno
" Annotate current file of a given revision                  | SVNAnnoShowRev <rev>
"
" Open a Revision under cursor (if you are                   | SVNRev
"                  in an annotated window)                   |
" Open a Revision from command line                          | SVNShowRev <rev>
"
" In revision window diff a file with its previous version   | Type gwb
" If you have just opened up a file from a commit and want   | SVNAnnoParentRev
"         to annoate the left-rev
" (Rare) Annotate current file on a different revision       | SVNAnnoShowRev <rev>
"
" Svn status (in case its a bit lengthy and you want on win) | SVNStatus
" Reset SVN info                                             | SVNReset
"
" SVN Log with <n> commits                                   | SVNLog {optinal-n}
com! SVNDiff   call ShowSvnCurrDiff(expand("%:p"))
com! SVNEdited call ShowSVNFiles()

com! SVNAnno   call DoSvnAnnotate(expand("%:p"))
com! -nargs=1 SVNAnnoShowRev call DoSvnAnnoRevision(<f-args>, ChompedSystem("svn info " . expand("%:p") . "| awk '/^URL/ {print $2}'"))

com! SVNRev    call DoSvnLogRevision(expand("<cWORD>"))
com! -nargs=1 SVNShowRev call DoSvnLogRevision(<f-args>)
com! SVNAnnoParentRev call DoSvnAnnoRevision(g:currentLoggedSVNRevParentForFile, g:currentLoggedFile)

com! SVNStatus call ShowSvnStatus()
com! SVNReset  call SvnResetGlobalInfo()

com! -nargs=* SVNLog  call ShowSvnLog(<f-args>)

com! -nargs=1 SVNShowRevOfFile call DoSvnDumpRevision(expand("%:p"),<f-args>)
com! -nargs=1 SVNShowRevOfFileAndDiff call DoSvnDumpRevisionAndDiff(expand("%:p"),<f-args>)


" ALL globals
" g:currentRepoPrefix
" g:asnRootPrefix
" g:currentLoggedSVNRev
" g:currentLoggedFile
" g:currentLoggedSVNRevParentForFile

function! SvnCheckAndSetRepoPrefix()
  if !exists('g:currentRepoPrefix')
      if filereadable ("./.branch_name")
        let l:branch = ChompedSystem("cat .branch_name")
      else
        echom "There is no .branch file. pwd is " . getcwd()
        return
      endif
      let s:cmdName = "svn info " . l:branch . " | grep '^URL:' | cut -d' ' -f2 | sed 's#\\(.*branches/[^/]*/\\).*#\\1#' "
      let g:currentRepoPrefix = ChompedSystem(s:cmdName)
      let g:asnRootPrefix = getcwd() . "/" . l:branch . "/"
      echom "g:currentRepoPrefix is set to " . g:currentRepoPrefix
  endif
endfunction

function! SvnResetGlobalInfo()
  silent! unlet g:currentRepoPrefix
  silent! unlet g:asnRootPrefix
  call SvnCheckAndSetRepoPrefix()
endfunction

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
endfunction

function! ShowSvnStatus()
  let s:temp_name = "__svn_status"
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn status"
  if !filereadable ("./.branch_name")
    0r "!echo no .branch file"
    return
  endif
  let s:branch = ChompedSystem("cat .branch_name")
  execute "lcd " . s:branch
  silent execute "0r !" . s:cmdName
  execute "lcd .."
  setlocal nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal gg"
endfunction

nnoremap gwb :call ShowSvnCurrDiff(expand("<cWORD>"))<CR>

function! DoSvnDumpRevision(filename, version)
  let s:lnum = line(".")
  let s:cmdName = "svn info " . a:filename . " | grep '^Path:' | cut -d' ' -f2"
  let s:repoFileName = ChompedSystem(s:cmdName)
  let g:currentLoggedFile = s:repoFileName

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

function! DoSvnDumpRevisionAndDiff(filename, version)
    execute "normal mZ"
    call DoSvnDumpRevision(a:filename, a:version)
    execute "vsplit"
    execute "normal `Z"
    call g:DiffCurrentWins()
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
endfunction

function! DoSVNRevWindowOpenRevDiff()
    let l:currentfile=expand("<cWORD>")
    execute "normal j"
    execute "normal 8|"
    silent call ShowSvnRevDiff(l:currentfile)
endfunction


function! DoSvnLogRevision(revision)
  call SvnCheckAndSetRepoPrefix()
  let g:currentLoggedSVNRev = a:revision
  let s:temp_name = "_rev_" . a:revision
  if bufexists(s:temp_name)
          execute "bd! " . s:temp_name
  endif
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn log --verbose -r" . a:revision . " " . substitute(g:currentRepoPrefix, "branches/.*", "", "")
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
  call SvnCheckAndSetRepoPrefix()
  " step-1: Get the left side revision number
  "  Incoming file will be of the form /branches/BRANCH_NAME/path/to/file
  let g:currentLoggedFile = substitute(g:currentRepoPrefix, "/branches/.*", "", "") . a:filename
  let s:cmdName = "svn diff -c" . g:currentLoggedSVNRev . " " . g:currentLoggedFile . " > /tmp/svn_plugin.patch"
  echom "command is " . s:cmdName
  call ChompedSystem(s:cmdName)
  let s:cmdName = "head -n 3 /tmp/svn_plugin.patch | grep -E -o 'revision [[:digit:]]+' | cut -d' ' -f2"
  let s:left_rev = ChompedSystem(s:cmdName)
  let s:cmdName = "svn info -r" . s:left_rev . " " . g:currentLoggedFile . " | grep 'Last Changed Rev:' | cut -d' ' -f4"
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
  let s:cmdName = "svn cat -r" . s:right_rev . " " . g:currentLoggedFile
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
  let s:cmdName = "svn cat -r" . s:left_rev . " " . g:currentLoggedFile
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

function! DoSvnAnnoRevision(revision, repo_file)
  " eg: revision:  29012
  "     repo_file: http://url_of_repo/branches/path/to/file
  let s:cmdName = "basename " . a:repo_file
  let l:smallname = ChompedSystem(s:cmdName)
  let s:temp_name = "_rev_" . a:revision . "_" . l:smallname
  if bufexists(s:temp_name)
    execute "bd! " . s:temp_name
  endif
  echom "bufname is set to " . s:temp_name
  let s:temp_anno_name = s:temp_name . "_anno"
  echom "annoname is set to " . s:temp_anno_name
  execute "tabnew " . s:temp_name
  let s:cmdName = "svn cat -r" . a:revision . " " . a:repo_file
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

  let s:cmdName = "svn annotate -v -r" . a:revision . " " . a:repo_file
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
  let l:revertdir=0
  if filereadable ("./.branch_name")
    let s:branch = ChompedSystem("cat .branch_name")
    execute "lcd " . s:branch
    let l:revertdir=1
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
  execute "normal gg"
  if l:revertdir == 1
      execute "lcd .."
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
    silent call ShowSvnCurrDiff(expand("<cWORD>"))
endfunction

function! GetRevOfFile(rev)
endfunction

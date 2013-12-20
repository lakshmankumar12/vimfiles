"Author: Ritesh Agarwal
"Email : rritesha@cisco.com,riteshja88@gmail.com
"Created : 5-May-2012
"Last edited : 20-June-2012

nmap <special> <F7> :call DoFindCRClean()<CR>
nmap <special> <F11> :call DoDumpCR(expand("<cWORD>"))<CR>
nmap <special> <F12> :call ListFiles(expand("%:p"))<CR>
nmap <special> <F10> :let @"= strpart(expand("%:p"),0,39)<CR>:display "<CR>

cmap fcr<CR> :call DoFindCR()<CR>
cmap afcr<CR> :call DoFindCRAllState()<CR>
cmap dcr<CR> :call DoDumpCR(expand("<cWORD>"))<CR>
cmap dcrad<CR> :call DoDumpCRAttachmentDownload(expand("%:p"),expand("<cWORD>"))<CR>
cmap dcra<CR> :call DoDumpCRAttachmentOpen(expand("%:t:r"),expand("<cWORD>"))<CR>
cmap fcrs<CR> :call DoFixCRChangeState(expand("<cWORD>"))<CR>
cmap note<CR> :call DoNote(expand("%:p"))<CR>
cmap anote<CR> :call DoAddNote(expand("%:p"))<CR>
cmap afile<CR> :call DoAddFile(expand("<cWORD>"))<CR> 
cmap anoter<CR> :call DoAddNoteRcomments(expand("<cWORD>"))<CR> 
cmap unitt<CR>  :call AddUnitTest(expand("%:p"))<CR>
cmap listf<CR>  :call ListFiles(expand("%:p"))<CR>
cmap anly<CR>   :call OpenAnalysis(expand("%:p"))<CR>

nmap ~listf     <Esc>:call ListFiles(expand("%:p"))<CR>
nmap ~anly      <Esc>:call OpenAnalysis(expand("%:p"))<CR>
nmap ~note      <Esc>:call DoNote(expand("%:p"))<CR>
nmap ~anote     <Esc>:call DoAddNote(expand("%:p"))<CR>
nmap ~ask       <Esc>:call AskDumpCR()<CR>
nmap ~asl       <Esc>:call AskDumpCRLite()<CR>
nmap ~unitt     <Esc>:call AddUnitTest(expand("%:p"))<CR>
nmap ~query     <Esc>:call DoFindAskFilters()<CR>
nmap ~datt      <Esc>:call DoDumpCRAttachmentDownload(expand("%:p"),expand("<cWORD>"))<CR>
nmap ~dhtt      <Esc>:call DoDumpCRAttachmentURLS(expand("%:p"))<CR>
nmap ~csti      <Esc>:call DoFixCRChangeStateInfoReq(expand("%:p"))<CR> 
nmap ~cstr      <Esc>:call DoFixCRChangeStateResolved(expand("%:p"))<CR> 
nmap ~cstd      <Esc>:call DoFixCRChangeStateDuplicate(expand("%:p"))<CR> 
nmap ~refr      <Esc>:call RefreshCR(expand("<cWORD>"))<CR>

let g:CachePath='/ws/lakskuma-bgl/prs/downloads/'
let g:CrefPath='/users/mitgblds/integration'
let g:tmpCscFile='/ws/lakskuma-bgl/anyoneszone/tmp_fcr'
let g:InterestedFields='Identifier,Severity-desc,Status,Headline,Attribute,Keyword,Est-fix-date,Component,Product,Regression,Submitter-id,Engineer,DE-manager,Related-bugs,"Duplicate-of"'
let g:FormatFields='"\%-11s|\%10s|\%1s|\%-80s|\%-25s|\%-40s|\%-20s|\%-10s|\%8s|\%1s|\%8s|\%8s|\%8s|\%15s|\%15s|\n"'

function! DoFindCRClean()
 " tabnew
 " tabmove 0
  call DoFindCR()
endfunction

function! OpenCdetsListFile()
  execute "tabnew"
  execute "tabmove 0"
  silent execute "0r " . g:tmpCscFile
  set nomodified
  set nowrap
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "normal 1G"
  execute "vsplit"
  execute "vert resize 10"
  execute "windo setlocal scrollbind"
  execute "normal 13|"
  execute "normal zs"
  redraw!
endfunction

function! DoFindCR()
  let s:cmdName = '!findcr -p CSC.asr5k,CSC.asr5k.general -h -d ";" -D "|" -u lakskuma -s NMIAO -w ' . g:InterestedFields . ' -o Severity,Attribute,Status,Est-fix-date -f ' . g:FormatFields . ' > ' . g:tmpCscFile
  silent execute s:cmdName
  call OpenCdetsListFile()
endfunction

function! DoFindCRAllState()
  let s:cmdName = '!findcr -p CSC.asr5k,CSC.asr5k.general -h -d ";" -D "|" -u lakskuma -w ' . g:InterestedFields . ' -o Severity,Attribute,Status,Est-fix-date -f ' . g:FormatFields . ' > ' . g:tmpCscFile
  silent execute s:cmdName
  call OpenCdetsListFile()
endfunction

function! DoFindAskFilters()
  let s:cmdName = '!findcr -p CSC.asr5k,CSC.asr5k.general -h -d ";" -D "|" '
  let s:cmdOpt = input("State Filter (blank-to-leave),Eg: NAIO, R, N, V, I:")
  if !empty(s:cmdOpt)
    let s:cmdName = s:cmdName . "-s " . s:cmdOpt . " "
  endif
  let s:cmdName = s:cmdName . "-w " . g:InterestedFields . ' -o Severity,Attribute,Status,Est-fix-date -f ' . g:FormatFields . ' "'
  let s:cumulativeOptions = ""
  let s:cmdOpt = input("Engineer Filter (blank-to-leave):")
  if !empty(s:cmdOpt)
    let s:cumulativeOptions = s:cumulativeOptions . "([Engineer] = '". s:cmdOpt ."')"
  endif
  let s:cmdOpt = input("DE-manager Filter (blank-to-leave):")
  if !empty(s:cmdOpt)
    if !empty(s:cumulativeOptions)
      let s:cumulativeOptions = s:cumulativeOptions . " AND "
    endif
    let s:cumulativeOptions = s:cumulativeOptions . "([DE-manager] = '". s:cmdOpt ."')"
  endif
  let s:cmdOpt = input("Submitter Filter (blank-to-leave):")
  if !empty(s:cmdOpt)
    if !empty(s:cumulativeOptions)
      let s:cumulativeOptions = s:cumulativeOptions . " AND "
    endif
    let s:cumulativeOptions = s:cumulativeOptions . "([Submitter] = '". s:cmdOpt ."')"
  endif
  let s:cmdName = s:cmdName . s:cumulativeOptions . '"' . ' > ' . g:tmpCscFile
  execute s:cmdName
  call OpenCdetsListFile()
endfunction

function! DoDumpCR(ddts)
  let s:dir_name = g:CachePath . strpart(a:ddts,3,2) . "/" . strpart(a:ddts,5,5) 
  silent execute "!mkdir -p " . s:dir_name
  let s:filename_full = s:dir_name . "/bug_op"
  let s:cmdName =  "!echo dumpcr " . a:ddts . " > " . s:filename_full 
  silent execute s:cmdName
  let s:cmdName =  "!dumpcr " . a:ddts . " >> " . s:filename_full 
  setlocal noswapfile
  silent execute s:cmdName
  silent execute "tablast"
  silent execute "tabnew " . s:filename_full
  silent execute "!/ws/lakskuma-bgl/work/tries/tcl/cdets_vim/log_a_cdets.tcl " . a:ddts . "&"
  set nowrap
endfunction

function! AskDumpCR()
  let s:cmdOpt = input("Enter Cdets-number:")
  call DoDumpCR(s:cmdOpt)
endfunction

function! RefreshCR(ddts)
  let s:dir_name = g:CachePath . strpart(a:ddts,3,2) . "/" . strpart(a:ddts,5,5) 
  let s:filename_full = s:dir_name . "/bug_op"
  silent execute "!rm " . s:filename_full
  let s:cmdName =  "!dumpcr " . a:ddts . " >> " . s:filename_full 
  silent execute s:cmdName
  silent execute "e! " . s:filename_full
endfunction

function! AskDumpCRLite()
  let s:ddts = input("Enter Cdets-number (Lite):")
  let s:dir_name = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) 
  let s:filename_full = s:dir_name . "/bug_op"
  silent execute "tablast"
  silent execute "tabnew " . s:filename_full
  setlocal noswapfile
  set nowrap
endfunction

function! DoDumpCRAttachmentDownload(ddts_dir,attachment) "Dumps CR attachment to a file in background
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:cmdOpt = input("Enter Attachment-Folder-number:")
  let s:cmdName = "!mkdir -p " . g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) . "/attachment" . s:cmdOpt
  echo s:cmdName
  silent execute s:cmdName
  let s:filename_full = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) . "/attachment" . s:cmdOpt . "/" . a:attachment
  let s:cmdName =  "!dumpcr -e -u -a \'" . a:attachment . "*\' " . s:ddts . " > " . s:filename_full  
  echo "executing " . s:cmdName
  silent execute s:cmdName
  redraw!
endfunction

function! DoDumpCRAttachmentURLS(ddts_dir) "Dumps all http links in CR attachment to a file 
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:filename_full = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) . "/att_links"
  let s:cmdName =  "!dumpcr -e -a 'http*' " . s:ddts . " > " . s:filename_full  
  echo "executing " . s:cmdName
  silent execute s:cmdName
  silent execute "tabnew " . s:filename_full
  setlocal noswapfile
  set wrap
endfunction


function! DoDumpCRAttachmentOpen(ddts,attachment) "Opens CR attachement in a new tab after downloading it
  let s:filename_full = g:CachePath . a:ddts . "_" . a:attachment
  let s:cmdName =  "!dumpcr -a \'" . a:attachment . "*\' " . a:ddts . " > " . s:filename_full
  silent execute s:cmdName
  silent execute "tabnew " . s:filename_full
  "set nowrap
  set wrap
  redraw!
endfunction

function! DoFixCRChangeState(ddts) "Fixcr..Change State of PR
  let s:cmdName = "fixcr " 
  echohl Keyword
  let s:cmdOpt = input("Enter \"fixcr\" options : ","-i " . a:ddts . " Status O ")
  echohl None
  let s:cmdName .= s:cmdOpt
  silent execute "0r !" . s:cmdName
  call DoFindCR()
endfunction

" Execute this after typing your I-comments in a new file.
function! DoFixCRChangeStateInfoReq(ddts_dir) 
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:cmdSubmitter = "cbugval -i " . s:ddts . " Submitter"
  let s:Submitter = substitute(system(s:cmdSubmitter), '[\]\|[[:cntrl:]]', '', 'g')
  let s:note_title = input("Enter I-comments-title (empty for I-comments):")
  if empty(s:note_title)
    let s:note_title = "I-comments"
  endif
  let s:cmdName = "fixcr -i " . s:ddts . " -n " . s:note_title . " -f " . a:ddts_dir . " Status I Info-awaiting " . s:Submitter 
  silent execute "0r !" . s:cmdName
endfunction

" Execute this after typing your R-comments in a new file
function! DoFixCRChangeStateResolved(ddts_dir) 
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:origin1 = input("Enter Origin (requirements|design|base code|new code|bad codefix|porting damage|synch/merge damage):")
  if empty(s:origin1)
    let s:origin1 = "base code"
  endif
  let s:origin = '''' . s:origin1 . ''''
  if (s:origin1 == "bad codefix" ) 
    let s:badcodeid = input("Enter bad-code-fix id:")
    let s:origin = s:origin . " BadcodefixId " . s:badcodeid
  endif
  let s:category = input("Enter Category (algorithm/logic|datahandling/initializ|error handling|external/userinterface|function|internalinterface|standards|timing/serialization|user documentation):")
  if empty(s:category)
    let s:category = "algorithm/logic"
  endif
  let s:reason = input("Enter reason (extra|missing|not clear|wrong):")
  if empty(s:reason)
    let s:reason = "missing"
  endif
  let s:note_title = input("Enter R-comments-title (R-comments):")
  if empty(s:note_title)
    let s:note_title = "R-comments"
  endif
  let s:cmdName = '!fixcr -i ' . s:ddts . ' -n ' . s:note_title . ' -f ' . a:ddts_dir . ' Status R Origin ' . s:origin . ' Category ''' . s:category . ''' Reason ''' . s:reason . ''' Behavior-changed N Dev-escape N Dev-escape-activity Not-A-Dev-Escape'
  echo "Executing " . s:cmdName
  let s:discard = input ("You can press ^C now if you find the above command not correct or type y:")
  execute "0r " . s:cmdName
endfunction

function! DoFixCRChangeStateDuplicate(ddts_dir) 
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:duplicateof = input("Enter Duplicate-of:")
  let s:note_title = input("Enter D-comments-title (D-comments):")
  if empty(s:note_title)
    let s:note_title = "D-comments"
  endif
  let s:cmdName = '!fixcr -i ' . s:ddts . ' -n ' . s:note_title . ' -f ' . a:ddts_dir . ' Status D Duplicate-of ' . s:duplicateof
  echo "Executing " . s:cmdName
  let s:discard = input ("You can press ^C now if you find the above command not correct or type y:")
  execute "0r " . s:cmdName
endfunction

function! DoNote(ddts_dir) "Add notes to PR. Does not attach. Use DoAddNote later
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:noteName = input("Enter Note-Name:")
  let s:comments_file_name = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) . "/" . s:noteName
  execute "tabnew " . s:comments_file_name
endfunction

function! DoAddNote(ddts_dir) "Add notes to PR. 
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:type = input("Enter type (R-comments/N-comments/D-comments/A-comments/Unit-test/Eng-notes):")
  let s:title = input("Enter title:")
  let s:cmdName = '!addnote '  . '-m -t ' . s:type . ' ' . s:ddts . ' "' . s:title . '" ' . a:ddts_dir
  silent execute s:cmdName
endfunction

function! DoAddFile(ddts) "Add File/Attachement to PR. Automatically chooses unique title' -m'
  let s:cmdName = "addfile " 
  echohl Keyword
  let s:attachment_file_name = g:CachePath . a:ddts . "_attachments"
  let s:cmdOpt = input("Enter \"addfile\" options : ","-m " . a:ddts . " Title " . "~/path_fo_file")
  echohl None
  let s:cmdName .= s:cmdOpt
  silent execute "0r !" . s:cmdName
endfunction

function! DoAddNoteRcomments(ddts) "Automatically Gets changeset from BitKeeper and adds details of changeset to DDTS 
  let s:cmdName = "addnote " 
  echohl Keyword
  let s:comments_file_name = g:CachePath . strpart(a:ddts,3,2) . "/" . strpart(a:ddts,5,5) . "/R-comment"
  let s:branch_name = input("Enter clone branch : ","v140.43798.all")
  echohl None
  execute "!echo \"[[[ Changeset in " . s:branch_name . " ]]]\" > " . s:comments_file_name
  execute "!cd " . g:CrefPath . " &&  cd " . s:branch_name . " && cd master/packages/boxer && bk changes -/" . a:ddts . "/ >> " . s:comments_file_name
  let s:cmdName .= "-m " . a:ddts . " R-Comments " . s:comments_file_name
"  echo s:cmdName
  silent execute "0r !" . s:cmdName
endfunction

function! AddUnitTest(ddts_dir)
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:dir_name = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) 
  let s:unit_test = s:dir_name . "/unit_test"
  if filereadable(s:unit_test)
    echo "Unit-test file " . s:unit_test . "already exists for this defect"
  else 
    let s:cmdName = "!cp /ws/lakskuma-bgl/work/notes/unit_test_template " . s:unit_test
    silent execute s:cmdName
    execute "tabnew " . s:unit_test
  endif
endfunction

function! ListFiles(ddts_dir)
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:dir_name = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) 
  silent execute "tabnew"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  silent execute "0r !find " . s:dir_name
endfunction

function! OpenAnalysis(ddts_dir)
  let s:ddts = "CSC" . strpart (a:ddts_dir, 31, 2) . strpart (a:ddts_dir, 34, 5)
  let s:dir_name = g:CachePath . strpart(s:ddts,3,2) . "/" . strpart(s:ddts,5,5) . "/mine"
  let s:analysis_file = s:dir_name . "/analysis"
  silent execute "!mkdir -p " . s:dir_name
  execute "tabnew " . s:analysis_file
endfunction


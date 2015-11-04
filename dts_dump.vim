"Author: Lakshman Kumar
"Email : lakshman_kumar.narayanan@alcatel-lucent.com,lakshmankumar@gmail.com
"Created : 10-Oct-2015

nmap <special> <F8> :call DoDumpDTS(expand("<cWORD>"))<CR>

cmap dcr<CR> :call DoDumpDTS(expand("<cWORD>"))<CR>

let g:CachePath='/home/lnara002/ws/dts/'

function! DoDumpDTS(ddts)
  let s:dts_only = strpart(a:ddts,3,6)
  let s:dir_name = g:CachePath . "/" . s:dts_only
  silent execute "!mkdir -p " . s:dir_name
  let s:filename_full = s:dir_name . "/" . s:dts_only . ".txt"
  let s:cmdName =  "!echo /drive_c/Users/lnara002/cygwin/repo-of-scripts/dts-pull/dts_pull.py -p " . s:dts_only . " > " . s:filename_full
  silent execute s:cmdName
  let s:cmdName =  "!/drive_c/Users/lnara002/cygwin/repo-of-scripts/dts-pull/dts_pull.py -p " . s:dts_only . " >> " . s:filename_full
  setlocal noswapfile
  silent execute s:cmdName
  silent execute "tablast"
  silent execute "tabnew " . s:filename_full
  set nowrap
endfunction


" Taken and adapted from https://gist.github.com/mattboehm/9977950
nnoremap <silent> <Leader>gg :call g:DiffCurrFile()<CR>
nnoremap <silent> <Leader>gj :call g:DiffNextLoc()<CR>
nnoremap <silent> <Leader>gk :call g:DiffPrevLoc()<CR>
nnoremap <silent> <Leader>go :call g:DiffOff()<CR>
nnoremap <silent> <Leader>gd :call g:DiffCurrentWins()<CR>
nnoremap <silent> <Leader>gl :call g:DiffOffWhenListMod()<CR>

command! -nargs=* Glistmod call g:ListModified(<f-args>)
command! Gbase call g:ListModified("base","--")
command! Gedited call g:ListModified("HEAD","--")

function! g:LoadFilesListCmd()
    let old_makeprg=&makeprg
    let old_errorformat=&errorformat
    let l:command = input("Enter Command:", "cat ~/tmp/files.lst")
    let &makeprg = l:command
    let &errorformat="%f"
    echom &makeprg
    silent lmake
    let &makeprg=old_makeprg
    let &errorformat=old_errorformat
    execute "ll"
endfunction

function! g:ListModified(lhs, rhs)
    execute "tabnew %"
    let old_makeprg=&makeprg
    let old_errorformat=&errorformat
    let g:lhs = a:lhs
    let g:rhs = a:rhs
    let &makeprg = "git diff --name-only " . a:lhs . " " . a:rhs
    let &errorformat="%f"
    echom &makeprg
    silent lmake
    let &makeprg=old_makeprg
    let &errorformat=old_errorformat
    execute "ll"
    silent call g:DiffCurrFile()
endfunction

" diffs the current file where cursor is
"   it depends on global vars g:lhs, and g:rhs to know the left and right
"   versions
function! g:DiffCurrFile()
    let l:n = winnr('$')
    if l:n > 1
      only
    endif
    set nosplitright
    execute "silent windo diffoff"
    execute "ll"
    execute "wincmd v"
    silent exec 'Gedit ' . g:lhs . ':' . expand("%")
    diffthis
    silent exec 'vertical resize '. string(&columns * 0.25)
    execute "wincmd l"
    if g:rhs != "--"
      silent exec 'Gedit ' . g:rhs . ':' . expand("%")
    endif
    diffthis
    execute "normal gg"
    set splitright
endfunction

function! g:DiffCurrentWins()
    let l:n = winnr('$')
    if l:n == 1
        "altreast 2 windows required
        return "Nothing"
    endif
    execute "normal mZ"
    silent exec 'windo diffoff'
    " utmost 4 windows for the script func to work. We will just come to
    " top-left
    silent exec 'wincmd h'
    silent exec 'wincmd k'
    silent exec 'diffthis'
    silent exec 'wincmd l'
    silent exec 'diffthis'
    execute "normal `Z"
endfunction


function! g:DiffNextLoc()
    wincmd l
    execute "windo diffoff"
    only
    lnext
    silent call g:DiffCurrFile()
endfunction

function! g:DiffPrevLoc()
    wincmd l
    execute "windo diffoff"
    only
    lprev
    silent call g:DiffCurrFile()
endfunction

function! g:DiffOff()
    let l:n = winnr()
    execute "normal mZ"
    silent exec 'windo diffoff'
    execute l:n . "wincmd w"
    execute "normal `Z"
endfunction

function! g:DiffOffWhenListMod()
    let l:n = winnr()
    execute "normal mZ"
    silent exec 'windo diffoff'
    silent exec 'wincmd h'
    silent exec 'close'
    silent exec 'lclose'
    silent exec 'lopen'
    silent exec 'wincmd k'
    execute "normal `Z"
endfunction

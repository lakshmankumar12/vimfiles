" Taken and adapted from https://gist.github.com/mattboehm/9977950
nnoremap <silent> <Leader>gg :call g:DiffCurrFile()<CR>
nnoremap <silent> <Leader>gj :call g:DiffNextLoc()<CR>
nnoremap <silent> <Leader>gk :call g:DiffPrevLoc()<CR>

command! -nargs=* Glistmod call g:ListModified(<f-args>)

function! g:ListModified(lhs, rhs)
    execute "only"
    windo set nodiff
    let old_makeprg=&makeprg
    let old_errorformat=&errorformat
    let g:lhs = a:lhs
    let g:rhs = a:rhs
    let &makeprg = "git diff --name-only " . a:lhs . " " . a:rhs
    let &errorformat="%f"
    echom &makeprg
    lmake
    let &makeprg=old_makeprg
    let &errorformat=old_errorformat
    ll
    call g:DiffCurrFile()
endfunction

function! g:DiffCurrFile()
    wincmd l
    let l:n = winnr('$')
    if l:n > 1
      only
    endif
    windo set nodiff
    execute "wincmd v"
    exec 'Gedit ' . g:lhs . ':' . expand("%")
    diffthis
    execute "wincmd l"
    exec 'Gedit ' . g:rhs . ':' . expand("%")
    diffthis
    execute "gg"
endfunction

function! g:DiffNextLoc()
    wincmd l
    only
    lnext
    call g:DiffCurrFile()
endfunction

function! g:DiffPrevLoc()
    wincmd l
    only
    lprev
    call g:DiffCurrFile()
endfunction


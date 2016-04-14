
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "panoslog"

syntax match PanosError /^\(ERROR\|CRIT\):.*/
syntax match PanosInfo /^INFO:.*/
syntax match PanosDebug /^DEBUG:.*/
syntax match PanosFailKeyword /\<FAIL\>/
syntax match PanosPassKeyword /\<PASS\>/
hi def link PanosError  Error
hi def link PanosInfo  String
hi def link PanosDebug Comment
hi def link PanosFailKeyword ToDo
hi def link PanosPassKeyword Keyword

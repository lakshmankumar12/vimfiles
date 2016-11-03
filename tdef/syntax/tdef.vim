
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "tdef"

syntax match TDefStepBlock /^StepBlock: */
syntax match TDefTestCase /TestCase: .*/
syntax match TDefImport /^Import: .*/
syntax match TDefDemarcate /^==========.*/
syntax match TDefComment /^#.*/
hi def link TdefStepBlock  Function
hi def link TdefTestCase  ToDo
hi def link TDefImport  Keyword
hi def link TDefDemarcate  Error
hi def link TDefComment  Comment

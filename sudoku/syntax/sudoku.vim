
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "sudoku"

syntax match SudokuGiven /\[\d\]/
syntax match SudokuFilled /(\d)/
hi def link SudokuFilled  Keyword
hi def link SudokuGiven  Error

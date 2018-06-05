
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "jira_op"

syntax match JiraOpHeading /\*\*\*\*\*\*\*\*   \S\+  \*\*\*\*\*\*\*\*\*/
syntax match JiraLine /----------------------------------------------------------------------------------------------------/
syntax match JiraByComment /^by: .* date:.*/
syntax match JiraPersonReference /[\~\[0-9A-Za-z._]\+]/
syntax region JiraCode start=/{noformat}/ end=/{noformat}/

hi def link JiraOpHeading  Error
hi def link JiraLine  Function
hi def link JiraCode  String
hi def link JiraByComment  Function
hi def link JiraPersonReference ToDo

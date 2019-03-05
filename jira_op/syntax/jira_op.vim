
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "jira_op"

syntax match JiraOpHeading /\*\*\*\*\*\*\*\*   \S\+  \*\*\*\*\*\*\*\*\*/
syntax match JiraLine /----------------------------------------------------------------------------------------------------/
syntax match JiraByComment /^by: .* date:.*/
syntax match JiraPersonReference /\v\[\~\S+\]/
syntax match JiraAnotherBug /ASN-\d\+/
syntax match JiraAnotherBug /ESC-\d\+/
syntax match JiraAnotherBug /REQ-\d\+/
syntax region JiraCode start=/{noformat}/ end=/{noformat}/
syntax region JiraCode start=/{code.*}/ end=/{code}/
syntax region JiraCode start=/{{/ end=/}}/

hi def link JiraOpHeading  Error
hi def link JiraLine  Function
hi def link JiraCode  String
hi def link JiraByComment  Function
hi def link JiraPersonReference ToDo
hi def link JiraAnotherBug ToDo

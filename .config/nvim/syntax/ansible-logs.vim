if exists('b:current_syntax')
  finish
endif

syntax keyword Reserved PLAY TASK PLAYBOOK ansible
syntax keyword Ssh SSH ESTABLISH CONNECTION FOR USER EXEC

syntax match Debug '^debug.:'
syntax match cmHost '\<[^ ]\{-}\.crewmeister\.com\>'

let b:current_syntax = 'csv'

highlight def link Reserved Special
highlight def link Ssh Statement
highlight def link cmHost Identifier
highlight def link Debug Function


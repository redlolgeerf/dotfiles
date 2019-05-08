if exists("b:current_syntax")
    finish
endif

echom "Our syntax highlighting code will go here."

syntax match ErrorMsg '\v####.*'
syntax match Todo '\v\d+-\d\d-\d\dT\d\d:\d\d:\d\d\.\d+.* \w+:'

let b:current_syntax = "jira"

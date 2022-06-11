" Vim syntax file
" Language:    None, used to beautify lecture notes
" Maintainer:  Christopher Pane <hahdookin@gmail.com>
" Last Change: 2021 Sept 3

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Keywords
syn keyword notesKeywordUrgent TODO contained 
syn match   notesKeywordUrgent 'EXAM QUESTION' contained

" Labels
syn match notesLabel '.*:' contains=notesKeywordUrgent,notesParenBlock

" Numbers
syn match notesNumber '\d\+'
syn match notesNumber '[+-]\d\+'
syn match notesNumber '[+-]\d\+\.\d\+'
"syn match notesNumber '0[xX][0-9a-fA-F]\+'
"syn match notesNumber '0[bB][01a-fA-F]\+'

" Ordered lists
syn match notesOrderedList '^\s*\d\+)' 

" Unordered lists
syn match notesUnorderedListPlus  '^\s*+'
syn match notesUnorderedListMinus '^\s*-'

" Parenthesised text
syn region notesParenBlock start="(" end=")"  contains=notesNumber
syn region notesParenBlock start="\[" end="]" contains=notesNumber
syn region notesParenBlock start="{" end="}"  contains=notesNumber
"syn region notesParenBlock start="<" end=">"  contains=notesNumber

" Defintions ($ <DefId> -> <Definition>)
syn match notesDefStart   '^\s*\$'          nextgroup=notesDefId contains=notesDefId skipwhite
syn match notesDefId      '[a-zA-Z0-9_-]\+' contained nextgroup=notesDefArrow,notesDefId skipwhite
syn match notesDefArrow   '->'         	    contained nextgroup=notesDefinition skipwhite
syn match notesDefinition '.*$'             contained contains=notesParenBlock,notesNumber


let b:current_syntax = "notes"

hi def link notesKeywordUrgent      Todo
hi def link notesLabel 	            Statement
hi def link notesNumber             Number

hi def link notesOrderedList        Special
hi def link notesUnorderedListPlus  Special
hi def link notesUnorderedListMinus PreProc

hi def link notesDefStart           Special
hi def link notesDefId 	    	    Function
hi def link notesDefArrow           Special
hi def link notesDefinition 	    Operator

hi def link notesParenBlock         PreProc

let &cpo = s:cpo_save
unlet s:cpo_save


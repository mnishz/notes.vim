" Vim global plugin to manage notes
" Last Change:  2018/11/04
" Maintainer:   mnishz0
" License:      This file is placed in the public domain.

if exists("g:loaded_notes")
  finish
endif
let g:loaded_notes = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 Note call notes#CreateNote(<f-args>)
command! -nargs=1 NoteMd call notes#CreateNote(<f-args>, v:true)
command! -nargs=0 OpenNote call notes#OpenNote()
command! -nargs=0 Trash call notes#CreateNote('', v:false, v:true) | q

let &cpo = s:save_cpo
unlet s:save_cpo

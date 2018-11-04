let s:FileDir = empty($XDG_DATA_HOME) ? expand('~/.local/share/notes') : $XDG_DATA_HOME

function! notes#CreateNote(fileName) abort
  if !isdirectory(s:FileDir) | call mkdir(s:FileDir, 'p') | endif
  let l:newFile = s:FileDir . '/' . strftime('%Y%m%d_%H%M%S_') . a:fileName . '.txt'
  if empty(getbufinfo('')[0].name)
    " save the current contents in case of unnamed buffer
    execute 'write ' . l:newFile
  else
    " open a new buffer if the current file already exists
    execute 'rightbelow vert new ' . l:newFile
  endif
endfunction

function! notes#OpenNote() abort
  execute 'e ' . s:FileDir
endfunction

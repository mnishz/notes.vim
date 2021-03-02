let s:DataHome = '~/.local/share'
if !empty($XDG_DATA_HOME)
  let s:DataHome = $XDG_DATA_HOME
elseif !empty($USERPROFILE)
  let s:DataHome = substitute($USERPROFILE, '\', '/', 'g') .. '/.local/share'
endif
let s:FileDir = expand(s:DataHome . '/notes')

" options
" TODO: not tested
let g:notes#file_dir = get(g:, 'notes#file_dir', expand(s:DataHome . '/notes'))

function! notes#CreateNote(fileName, markDown = v:false, trash = v:false) abort
  let l:dir = a:trash ? s:FileDir .. '/trash' : s:FileDir
  if !isdirectory(l:dir) | call mkdir(l:dir, 'p') | endif
  let l:newFile = l:dir . '/' . strftime('%Y%m%d_%H%M%S_') . a:fileName
  let l:newFile .= a:markDown ? '.md' : '.txt'
  if empty(getbufinfo('')[0].name)
    " save the current contents in case of unnamed buffer
    execute 'write ' . l:newFile
  else
    " open a new buffer if the current file already exists
    execute 'rightbelow vert new ' . l:newFile
  endif
endfunction

function! notes#OpenNote() abort
  let l:org = exists("g:netrw_sort_direction") ? g:netrw_sort_direction : 'normal'
  let g:netrw_sort_direction = 'reverse'
  execute 'e ' . s:FileDir
  let g:netrw_sort_direction = l:org
endfunction

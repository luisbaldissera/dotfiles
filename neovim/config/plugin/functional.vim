function! functional#sorted(list)
  let l:newlist = deepcopy(a:list)
  call sort(l:newlist)
  return l:newlist
endfunction

function! functional#reversed(list)
  let l:newlist = deepcopy(a:list)
  call reverse(l:newlist)
  return l:newlist
endfunction

function! functional#append(list, value)
  let l:newlist = deepcopy(a:list)
  call add(l:newlist, a:value)
  return l:newlist
endfunction

function! functional#assoc(list, index, value)
  let l:newlist = deepcopy(a:list)
  let l:newlist[a:index] = a:value
  return l:newlist
endfunction

function! functional#pop(list, index)
  let l:newlist = deepcopy(a:list)
  call remove(l:newlist, a:index)
  return l:newlist
endfunction

function! functional#mapped(list, function)
  let l:newlist = deepcopy(a:list)
  call map(l:newlist, string(a:function) . '(v:val)')
  return l:newlist
endfunction

function! functional#filtered(list, function)
  let l:newlist = deepcopy(a:list)
  call filter(l:newlist, string(a:function) . '(v:val)')
  return l:newlist
endfunction

function! functional#removed(list, function)
  let l:newlist = deepcopy(a:list)
  call filter(l:newlist, '!' . string(a:function) . '(v:val)')
  return l:newlist
endfunction

function! functional#reduced(list, function, initial)
  let l:newlist = deepcopy(a:list)
  call reduce(a:list, a:function, a:initial)
  return l:newlist
endfunction

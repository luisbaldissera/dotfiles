function! Person(name)
  function! PersonSay(text) dict
    echom self.name ':' a:text
  endfunction

  return #{ name: a:name, say: function('PersonSay') }
endfunction

function! Sum(...)
  let l:result = 0
  for index in range(1, a:0)
    let l:result = l:result + get(a:, index)
  endfor
  echo a:000
  return l:result
endfunction

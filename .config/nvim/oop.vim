" Inspiration

function! Person(name)
  function! PersonSay(text) dict
    echom self.name ':' a:text
  endfunction

  return #{ name: a:name, say: function('PersonSay') }
endfunction


let p = Person('Luis')
call p.say('Hello')
" Luis : Hello

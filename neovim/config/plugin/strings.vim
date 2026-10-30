function! strings#Camel(input)
    " Replace underscores followed by a character with the uppercase version of the character
    let l:camelCase = substitute(a:input, '\v(_)(\w)', '\u\2', 'g')
    " Convert the first character of the string to lowercase
    let l:camelCase = substitute(l:camelCase, '\v(^\w)', '\l\1', '')
    return l:camelCase
endfunction

function! strings#Snake(input)
    " Replace uppercase characters with an underscore followed by the lowercase version of the character
    let l:snakeCase = substitute(a:input, '\v(\u)', '_\l\1', 'g')
    " Convert the first character of the string to lowercase
    let l:snakeCase = substitute(l:snakeCase, '\v(^\w)', '\l\1', '')
    return l:snakeCase
endfunction

function! strings#Kebab(input)
    " Replace uppercase characters with a dash followed by the lowercase version of the character
    let l:kebabCase = substitute(a:input, '\v(\u)', '-\l\1', 'g')
    " Convert the first character of the string to lowercase
    let l:kebabCase = substitute(l:kebabCase, '\v(^\w)', '\l\1', '')
    return l:kebabCase
endfunction

function! strings#Pascal(input)
    " Replace underscores followed by a character with the uppercase version of the character
    let l:pascalCase = substitute(a:input, '\v(_)(\w)', '\u\2', 'g')
    return l:pascalCase
endfunction

function! strings#RemoveLast(str, len)
  return a:str[0:-a:len-1]
endfunction

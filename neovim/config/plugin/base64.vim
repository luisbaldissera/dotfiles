if executable('base64')
  function! base64#encode(message)
    return system('base64 <<< "'. a:message . '"')
  endfunction

  function! base64#decode(base64)
    return system('base64 --decode <<< "'. a:base64 . '"')
  endfunction
else
  echoerr 'Fail to load base64 plugin: base64 not found'
endif

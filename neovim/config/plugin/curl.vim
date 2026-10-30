if executable('curl')
  " Make a curl request and return the response
  " url: http://some.host/api/v1/...
  " options: dictionary that can contains:
  "   method: GET, POST, PUT, PATCH, DELETE, ...
  "   header: key-value dictionary with the headers to be includued
  "   body: string of the body
  "   params: query params
  "
  function! curl#request(url, options = {})
    let l:method = a:options->get('method', v:null)
    let l:headers = a:options->get('headers', {})
    let l:body = a:options->get('body', v:null)
    let l:curlcmd = 'curl ' .. shellescape(a:url)
    if l:method !=# v:null
      let l:curlcmd ..= ' --request ' .. shellescape(l:method)
    endif
    for [key, value] in items(l:headers)
      let l:curlcmd ..= ' --header ' .. shellescape(key .. ': ' .. value)
    endfor
    if l:body !=# v:null
      let l:curlcmd ..= ' --data-raw ' .. shellescape(l:body)
    endif
    let l:curlcmd ..= ' 2>/dev/null'
    return system(l:curlcmd)
  endfunction

  " Make a curl request and return the response
  "
  " params:
  "   url: the url to make the request to
  "   options: dictionary that can contains:
  "     method: GET, POST, PUT, PATCH, DELETE, ...
  "     header: key-value dictionary with the headers to be includued
  "     body: string of the body
  "     params: query params TODO: implement it
  "
  " returns a dictionary that contains
  "    protocol: (string) e.g. 'HTTP/1.1',
  "    status: (number) e.g. 200,
  "    headers: a key=value dict of the response headers,
  "    body: (string) the response body, can be empty
  function! curl#sync(url, options = {})
    " Options
    let l:method  = a:options->get('method', v:null)
    let l:headers = a:options->get('headers', {})
    let l:body    = a:options->get('body', v:null)
    " Prepare the cURL command
    let l:curlcmd = 'curl --include ' .. shellescape(a:url)
    if l:method !=# v:null
      let l:curlcmd ..= ' --request ' .. shellescape(l:method)
    endif
    for [key, value] in items(l:headers)
      let l:curlcmd ..= ' --header ' .. shellescape(key .. ': ' .. value)
    endfor
    if l:body !=# v:null
      let l:curlcmd ..= ' --data-raw ' .. shellescape(l:body)
    endif
    let l:curlcmd ..= ' 2>/dev/null'
    " Execute the cURL command
    let l:response = system(l:curlcmd)
    " Post-process the response
    let l:lines = l:response->split('\r\n')
    let l:firstline = l:lines[0]
    let [l:protocol, l:status] = l:firstline->split()
    let l:index = 1
    let l:headers = {}
    while l:lines[l:index] !=# ''
      let [l:header, l:value] = l:lines[l:index]->split(': ')
      let l:headers[l:header] = l:value
      let l:index = l:index + 1
    endwhile
    let l:body = l:lines[l:index:]->join('')
    " Return the result object
    return #{
          \ protocol : l:protocol,
          \ status   : str2nr(l:status),
          \ headers  : l:headers,
          \ body     : l:body
          \ }
  endfunction
else
  echoerr 'Fail to load curl plugin: curl not found'
endif

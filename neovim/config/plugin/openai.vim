let g:openai_chat_model = 'gpt-3.5-turbo'
let g:openai_api_key = 'not-a-real-api-key'

if exists('$OPENAI_API_KEY')
  let g:openai_api_key = $OPENAI_API_KEY
endif

function! openai#chat(message)
  let l:body = #{
        \   model: g:openai_chat_model,
        \   messages: [
        \     #{ role: 'user', content: a:message }
        \   ]
        \ }
  let l:body = json_encode(l:body)
  let l:headers = {
        \   'Content-type': 'application/json',
        \   'Authorization': 'Bearer ' .. g:openai_api_key
        \ }
  let l:response = curl#request(
        \ 'https://api.openai.com/v1/chat/completions',
        \ #{
        \ method: 'GET',
        \ headers: l:headers,
        \ body: l:body
        \ })
  let l:resp = json_decode(l:response)
  let l:choices = get(l:resp, 'choices')
  let l:last = get(l:choices, len(l:choices) - 1)
  let l:message = get(l:last, 'message')
  let l:content = get(l:message, 'content')
  echo substitute(l:content, '\\n', '\r', 'g')
  endfunction

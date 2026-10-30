let g:csv_delim = ','
let g:csv_eol   = "\n"


" Receives a list of objects like:
" [ #{ a: 1, b: 'one' }, #{ a: 2, b: 'two' } ]
"
" And returns a list of csv lines like:
" [ 'a,b', '1,one', '2,two' ]
function! csv#from_list(list, options = {})
  let l:delim = a:options->get('delim', g:csv_delim)
  let l:keycount = {}
  let l:csv = []
  for element in a:list
    for key in keys(element)
      let l:keycount[key] = get(l:keycount, key, 0) + 1
    endfor
  endfor
  let l:header = keys(l:keycount)->join(l:delim)
  let l:csv = l:csv->add(l:header)
  for element in a:list
    let l:values = []
    for key in keys(l:keycount)
      let l:value = element->get(key, '')->string()
      let l:values = l:values->add(l:value)
    endfor
    let l:row = l:values->join(l:delim)
    let l:csv = l:csv->add(l:row)
  endfor
  return l:csv
endfunction

function! csv#to_list(csv, options = {})
  let l:delim = a:options->get('delim', g:csv_delim)
  let l:eol = a:options->get('eol', g:csv_eol)
  let l:lines = a:csv->split(g:csv_eol)
  let l:keys = l:lines->get(0)->split(g:csv_delim)
  let l:list = []
  for lineindex in range(1, l:lines->len() - 1)
    let l:line = l:lines->get(lineindex)
    let l:row = line->split(g:csv_delim)
    let l:obj = {}
    for rowindex in l:keys->len()->range()
      let l:key = l:keys->get(rowindex)
      let l:value = l:row->get(rowindex, '')
      let l:obj[l:key] = l:value
    endfor
    call add(l:list, l:obj)
  endfor
  return l:list
endfunction

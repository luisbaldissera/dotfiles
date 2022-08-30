let s:configfile = $HOME . '/.config/nvim/custom/fold.json'
let s:config = json_decode(readfile(s:configfile))
let s:foldmethods = s:config.foldmethods

augroup fold_group
  autocmd!
  for method in keys(s:foldmethods)
    for extension in s:foldmethods[method]
      exec 'autocmd FileType ' . extension . ' setlocal foldmethod=' . method
    endfor
  endfor
augroup end


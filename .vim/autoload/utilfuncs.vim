function! utilfuncs#SumNumbersInVisual() range
  " 選択範囲の行番号
  let l:start = line("'<")
  let l:end   = line("'>")

  " 選択範囲の列番号（矩形用）
  let l:c1 = virtcol("'<")
  let l:c2 = virtcol("'>")
  if l:c1 > l:c2
    let [l:c1, l:c2] = [l:c2, l:c1]
  endif

  let l:sum = 0

  " 対象行を1行ずつ処理
  for lnum in range(l:start, l:end)
    let l:line = getline(lnum)

    " 列範囲を抽出（slice）
    let l:rowtext = strpart(l:line, l:c1 - 1, l:c2 - l:c1 + 1)

    " 行内の数字を全部抽出
    let l:nums = split(substitute(l:rowtext, '\D\+', ' ', 'g'))

    for n in l:nums
      if n != ''
        let l:sum += str2nr(n)
      endif
    endfor
  endfor

  call input('Sum: ' . l:sum)
endfunction

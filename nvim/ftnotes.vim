au BufRead,BufNewFile *.notes set filetype=notes
au BufRead,BufNewFile *.notes setlocal spell

function ILine()
    let start_line_pos = getpos('.')[1]
    let start_line = getline('.')
    let index = match(start_line, '^\s*\d\+')
    if index != -1
        " Re-index lines ahead if needed
        let i = 1
        let this_line = getline(start_line_pos + i)
        let this_match = match(this_line, '^\s*\d\+')
        while this_match != -1
            let close = match(this_line, ')')
            let digit = match(this_line, '\d')
            let prev_num = getline(start_line_pos + i - 1)[match(start_line, '\d'):match(start_line, ')') - 1]
            "let number = this_line[digit:close-1]
            let number = str2nr(this_line[digit:close-1])
            if number != prev_num + 1
                break
                let number = prev_num + 1
            endif
            let new_num = str2nr(number) + 1

            call setline(start_line_pos + i, new_num . this_line[close:])

            " Prepare for next iteration
            let i += 1
            let this_line = getline(start_line_pos + i)
            let this_match = match(getline(start_line_pos + i), '^\s*\d\+')
        endwhile
        call feedkeys("^yt)o\<ESC>p\<C-a>A) ")
        " let now_line = getline(start_line_pos + i - 1)
        " let close = match(now_line, ')')
        " let digit = match(now_line, '\d')
        " let number = now_line[digit:close - 1]
        " let number = str2nr(number) + 1
        " put =''
        " call setline(start_line_pos + i, number . ") ")
        " call cursor(start_line_pos + i, len(number) + 2)
    else
        call feedkeys("o")
    endif
endfunction

nnoremap <buffer> <leader>F :call ILine()<CR>

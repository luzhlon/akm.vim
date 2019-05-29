" =============================================================================
" Filename:    autoload/akm.vim
" Author:      luzhlon
" Date:        2019-05-24
" Description: Awesome Key Mapping
" =============================================================================

" Execute a command in normal mode, keep the cursor position
fun! akm#normal(ks, ...)
    let c = col('.')
    exe a:0 ? 'norm!': 'norm' a:ks
    call cursor(line('.'), c)
    return ''
endf

" Call 'feedkeys' and return ''
fun! akm#feedkeys(...)
    call call('feedkeys', a:000) | return ''
endf

" Execute a command and return ''
fun! akm#exec(cmd)
    exe a:cmd | return ''
endf

" Auto redraw like emacs's Ctrl-L
fun! akm#auto_redraw()
    let l = winline()
    let cmd = l * 2 <= winheight(0) + 1 ? l <= (&so + 1) ? 'zb' : 'zt' : 'zz'
    return mode() == 'i' ? akm#normal(cmd, '!'): cmd
endf

" Delete chars to the end of word
fun! akm#del_to_wordend()
    return col('.') == col('$') ? "\<del>" : akm#normal('dw', '!')
endf

" Delete chars to the end of line
fun! akm#del_to_linend()
    return col('.') == col('$') ? "\<del>" : akm#normal('D', '!')
endf

" Move cursor to first column or first non-blank char
fun! akm#move_to_head()
    let space_count = len(matchstr(getline('.'),'^\s*'))
    let c = col('.') - 1 == space_count ? '0': '^'
    if mode() == 'i'
        exe 'norm!' c
        return ''
    else
        return c
    endif
endf

fun! akm#move_to_end()
    let m = mode()
    if m =~# '\v^i'
        return getline('.')[col('.')-1:] =~ '\v^\s+$' ? "\<end>": "\<esc>g_a"
    endif
    if m =~? '\v^(n|v)' || m == "\<c-v>"
        return getline('.')[col('.'):] =~ '\v^\s+$' ? '$': 'g_'
    endif
    return ''
endf

fun! akm#paste(t)
    if mode()[0] == 'i'
        let @- = a:t
        exe 'norm!' '"-' . (col('.') == col('$') ? 'p' : 'P')
        return "\<right>"
    else
        set paste
        call timer_start(0, {->execute('set nopaste')})
        return a:t
    endif
endf

" commandline-edit {{{
fun! akm#cmd_del_to_wordend()
    let pos = getcmdpos()
    let text = getcmdline()[pos-1:]
    let blank = matchstr(text, '^\s\+')
    if len(blank)
        return repeat("\<del>", len(blank))
    else
        call timer_start(1, {->feedkeys(repeat("\<bs>", getcmdpos()-pos), 'n')})
        return "\<c-right>"
    endif
endf

fun! akm#cmd_forward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 1
    " Skip the non-word chars
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    " Move to previous word left
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos < len(cmd)
        let pos += 1
    endw
    call setcmdpos(pos + 1)
    return ''
endf

fun! akm#cmd_backward_word()
    let cmd = getcmdline()
    let pos = getcmdpos() - 2
    " Skip the non-word chars
    while cmd[pos] !~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    " Move to next word right
    while cmd[pos] =~ '\w\|[^\x00-\xff]' && pos >= 0
        let pos -= 1
    endw
    call setcmdpos(pos + 2)
    return ''
endf

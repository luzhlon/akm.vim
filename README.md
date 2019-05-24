
Awesome KeyMapping for (Neo)Vim: including some keymappings of popular editors, some keymappings from emacs, etc.

## Configuration

```viml
" Emacs's keymappings
inoremap <silent><m-f> <c-r>=akm#exec('norm! e')<cr><right>
inoremap <silent><m-d> <c-r>=akm#del_to_wordend()<cr>
" inoremap <m-b> <c-left>
" inoremap <c-n> <down>
" inoremap <c-p> <up>
" inoremap <m-n> <PageDown>
" inoremap <m-p> <PageUp>
inoremap <silent><c-k> <c-r>=akm#del_to_linend()<cr>
inoremap <silent><c-a> <c-r>=akm#move_to_head()<cr>
inoremap <silent><c-e> <c-r>=akm#move_to_end()<cr>
inoremap <silent><c-l> <c-r>=akm#auto_redraw()<cr>

cnoremap <m-f> <c-r>=akm#cmd_forward_word()<cr>
cnoremap <m-b> <c-r>=akm#cmd_backward_word()<cr>
cnoremap <expr><m-d> akm#cmd_del_to_wordend()

xnoremap <expr><c-e> akm#move_to_end()
nnoremap <expr><c-e> akm#move_to_end()
nnoremap <expr><c-l> akm#auto_redraw()

nnoremap <expr><c-l> akm#auto_redraw()
noremap  <expr>0     akm#move_to_head()

inoremap <silent><m-s-k> <c-r>=akm#normal('ddkP')<cr>
inoremap <silent><m-s-j> <c-r>=akm#normal('ddp')<cr>

" Undo and redo
inoremap <silent><c-z> <c-r>=akm#exec('undo')<cr>
inoremap <silent><c-y> <c-r>=akm#exec('redo')<cr>

" Paste
noremap! <c-g><c-p> <c-r>=akm#paste(@@)<cr>
noremap! <c-g><c-f> <c-r>=akm#paste(@%)<cr>
noremap! <c-g><c-d> <c-r>=akm#paste(expand('%:h'))<cr>
noremap! <c-v> <c-r>=akm#paste(@+)<cr>
noremap <silent><c-v> "=akm#paste(@+)<cr>p
```

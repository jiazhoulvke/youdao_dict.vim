" youdao_dict
" Author:   jiazhoulvke
" Email:    jiazhoulvke@gmail.com 
" Blog:     http://www.jiazhoulvke.com 
" Version:  0.1
" --------------------------------------
if has('python3')
    command! -nargs=1 Python python3 <args>
elseif has('python')
    command! -nargs=1 Python python <args>
else
    finish
endif

if exists('g:youdao_dict_loaded')
    finish
endif
let g:youdao_dict_loaded = 1

let s:bname = '__YOUDAO_DICT__'

if !exists('g:youdao_dict_translate_key')
    let g:youdao_dict_translate_key = '<F12>'
endif

if !exists('g:youdao_dict_translate_command')
    let g:youdao_dict_translate_command = 'YouDao'
endif

if !exists('g:youdao_dict_nomap')
    let g:youdao_dict_nomap = 0
endif

if !exists('g:youdao_dict_nocmd')
    let g:youdao_dict_nocmd = 0
endif

function! Youdao_Dict(word)
Python << EOF
#coding=utf-8
import vim,requests
from pyquery import PyQuery
word = vim.eval("a:word")
word = word.replace('\n','')
req = requests.get('http://dict.youdao.com/search?q=' + word)
pq = PyQuery(req.content)
trans = pq('#phrsListTab .trans-container').text()
vim.command('let result = "%s"' % trans)
EOF
return result
endfunction

function! Youdao_Dict_Selected_String()
    normal `<
    normal v
    normal `>
    silent normal "ty
    return Youdao_Dict(@t)
endfunction

function! Youdao_Dict_Command(word)
    let result = Youdao_Dict(a:word)
    let winnum = bufwinnr(s:bname)
    if winnum != -1
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
        setlocal modifiable
        silent! %delete _
    else
        let bufnum = bufnr(s:bname)
        if bufnum == -1
            let wcmd = s:bname
        else
            let wcmd = '+buffer' . bufnum
        endif
        exe 'silent! botright ' . g:ultilocate_window_height . 'split ' . wcmd
    endif
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nowrap
    setlocal nobuflisted
    setlocal winfixheight
    setlocal modifiable
    silent! %delete _
    silent! 0put = result
    silent! $delete _
    normal! gg
endfunction

if g:youdao_dict_nomap == 0
    exe 'nmap <silent> ' . g:youdao_dict_translate_key . " :echo Youdao_Dict(expand('<cword>'))<CR>"
    exe 'vmap <silent> ' . g:youdao_dict_translate_key . " <ESC>:echo Youdao_Dict_Selected_String()<CR>"
endif

if g:youdao_dict_nocmd == 0
    exe 'command! -nargs=+ ' . g:youdao_dict_translate_command . " :echo Youdao_Dict_Command(<q-args>)"
endif

" vim: ft=vim

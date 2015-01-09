" youdao_dict
" Author:   jiazhoulvke
" Email:    jiazhoulvke@gmail.com 
" Blog:     http://www.jiazhoulvke.com 
" Version:  0.1
" --------------------------------------

if exists('g:youdao_dict_loaded')
    finish
endif
let g:youdao_dict_loaded = 1

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
python << EOF
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

if g:youdao_dict_nomap == 0
    exe 'nmap <silent> ' . g:youdao_dict_translate_key . " :echo Youdao_Dict(expand('<cword>'))<CR>"
    exe 'vmap <silent> ' . g:youdao_dict_translate_key . " <ESC>:echo Youdao_Dict_Selected_String()<CR>"
endif

if g:youdao_dict_nocmd == 0
    exe 'command! -nargs=+ ' . g:youdao_dict_translate_command . " :echo Youdao_Dict(<q-args>)"
endif

" vim: ft=vim

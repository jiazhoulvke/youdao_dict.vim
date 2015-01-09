#有道词典 for Vim

##安装

本插件依赖两个python模块:

```
    pip install requests
    pip install pyquery
```
    
* Vundle 

```
    Plugin 'jiazhoulvke/youdao_dict.vim'
```

* Pathogen 
    
```
    git clone https://github.com/jiazhoulvke/youdao_dict.vim ~/.vim/bundle/youdao_dict.vim
```

##配置

* 修改绑定按键(默认为\<F12\>)

```
    let g:youdao_dict_translate_key = '<C-t>'
```

* 绑定命令(默认为YouDao)

```
    let g:youdao_dict_translate_command = 'FanYi'
```

* 禁止绑定按键

```
    let g:youdao_dict_nomap = 1
```

* 禁止绑定命令

```
    let g:youdao_dict_nocmd = 1
```

##使用

* 移动光标到需要翻译的单词上面按<F12>

* 选中需要翻译的文本按<F12>

* 输入":YouDao 要翻译的的单词"并按回车

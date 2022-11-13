# vim environment

My vim environments.

## how to update vimrc

1. Get vimrc to your home dir, delete your old .vim directory and then rename vimrc to .vim
2. Change directory to .vim, and run: sh update_vimrc.sh

## Key Function
```
" +----------+---------------------+
" | Key      | Function            |
" +----------+---------------------+
" | F2       | paste模式开关       |
" | F3       | NerdTREE开关        |
" | F4       | tagbar开关          |
" | F5       | 行号模式切换        |
" | F6       | 是否显示特殊字符    |
" | F7       | 更新ctags文件       |
" | F8       | 打开undotree        |
" | F9       | 进入MultiCursor模式 |
" | F10      | 打开YankRing剪贴板  |
" | F12      | 鼠标模式切换        |
" | <Ctrl+c> | 快速推出VIM(:qall!) |
" +----------+---------------------+
```

## Problems
1. It may throw a problem as follow when used in mac os:
```
Error detected while processing function <SNR>16_HighlightEOLWhitespaceExceptCurrentLine:
line    1:
E461: Illegal variable name: a:exclude_current_line_eol_whitespace_pattern
```
We could fix this by upgrading `vim-better-whitespace` in https://github.com/ntpeters/vim-better-whitespace.

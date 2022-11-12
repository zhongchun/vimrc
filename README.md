# vim environment

My vim environments.

## how to update vimrc

1. Get vimrc to your home dir, delete your old .vim directory and then rename vimrc to .vim
2. Change directory to .vim, and run: sh update_vimrc.sh

## Problems
1. It may throw a problem as follow when used in mac os:
```
Error detected while processing function <SNR>16_HighlightEOLWhitespaceExceptCurrentLine:
line    1:
E461: Illegal variable name: a:exclude_current_line_eol_whitespace_pattern
```
We could fix this by upgrading `vim-better-whitespace` in https://github.com/ntpeters/vim-better-whitespace.

"|------------------------|
"|    Coolceph VIMRC      |
"|------------------------|
"|           _            |
"|   __   __(_)___ ___    |
"|   | | / / / __ `__ \   |
"|   | |/ / / / / / / /   |
"|   |___/_/_/ /_/ /_/    |
"|                        |
"|------------------------|
"
" Maintainer:	coolceph <https://github.com/coolceph/vimrc-min>
" Last change:	2017.12.28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"
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

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"默认关闭鼠标，方便Terminal下操作
if has('mouse')
  set mouse-=a
endif

"MacVim工作在gui模式，需要设置字体
"在Powerline字体开启时，需要选择Powerline字体，例如原版Source\ Code\ Pro或者SF\ Mono\ for\ Powerline
"在Powerline字体关闭时，可以任意选择等宽字体
"GUI模式开启鼠标支持，关闭左右的scrollbar
if has("gui_running")
    set guifont=SFMono\ Nerd\ Font:h12
    set mouse=a
    set guioptions-=r
    set guioptions-=L
    set guicursor+=a:blinkon0 "光标不闪烁
endif

"当有termguicolors特性时开启GUI配色
"20180125:在tmux中不开启gurcolor
if has("termguicolors")
    let g:colorterm = $COLORTERM
    if g:colorterm=="truecolor"
        set termguicolors
    endif
endif

"代码缩进设置
set smarttab      "开启时，在行首按TAB将加入sw个空格，否则加入ts个空格
set tabstop=4     "编辑时一个TAB字符占多少个空格的位置
set softtabstop=4 "方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
set shiftwidth=4  "使用每层缩进的空格数
set expandtab     "是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
" set updatetime=250

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType make setlocal noexpandtab
    autocmd FileType python setlocal expandtab smarttab shiftwidth=4 softtabstop=4
    autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=8 smarttab

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

set history=1024
set number                                       " 显示行号
set autoread                                     " 文件在Vim之外修改过，自动重新读入
set showbreak=↪                                  " 显示换行符
set completeopt=longest,menu                     " 更好的insert模式自动完成
set modeline                                     " 允许被编辑的文件以注释的形式设置Vim选项
set hidden                                       " switching buffers without saving
set ruler                                        " show the cursor position all the time
set showcmd                                      " display incomplete commands
set wildmenu                                     " show enhanced completion
set wildmode=list:longest                        " together with wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set visualbell                                   " flash screen when bell rings
set cursorline                                   " highline cursor line
set ttyfast                                      " indicate faster terminal connection
set laststatus=2                                 " always show status line
set cpoptions+=J
set linebreak                                    " break the line by words
set scrolloff=3                                  " show at least 3 lines around the current cursor position
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block
set lazyredraw
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set splitbelow
set splitright
set fillchars=diff:⣿
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Resize splits when the window is resized
au VimResized * :wincmd =

"开关复制模式
fun! TogglePasteMode()
    if !exists("s:old_pastemode")
        let s:old_pastemode = "1"
    endif

    if s:old_pastemode == "0"
        let s:old_pastemode = "1"
        set number
        set nopaste
        :EnableWhitespace
        :IndentLinesEnable
        call gitgutter#enable()

        if exists("s:old_pastemouse")
            let &mouse = s:old_pastemouse
        endif

        if exists("s:old_pastelist")
            let &list=s:old_pastelist
        endif

        echo "set edit mode"
    else
        let s:old_pastemode = "0"
        set nonumber
        set norelativenumber
        set paste
        :DisableWhitespace
        :IndentLinesDisable
        call gitgutter#disable()

        let s:old_pastemouse = &mouse
        let &mouse=""

        let s:old_pastelist = &list
        let &list="0"

        echo "set copy/paste mode"
    endif
endfunction

"使用F2切换复制/粘帖模式和正常编辑模式
noremap <F2> :call TogglePasteMode()<CR>
inoremap <F2> <ESC>:call TogglePasteMode()<CR>i

" toggle between no number, absolute number and relative number
function! ToggleNumber()
    if !&number && !&relativenumber
        set number
    elseif !&relativenumber
        set relativenumber
    else
        set nonumber
        set norelativenumber
    endif
endfunc

"使用F5切换行号模式
noremap <F5> :call ToggleNumber()<CR>

"使用F6开关list字符
noremap <F6> :set invlist<CR>:set list?<CR>

"使用F7更新ctags
fun! UpdateCtags()
    !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
    echo "Create ctags OK"
endfunction

noremap <F7> :call UpdateCtags()<CR>

"鼠标模式切换
fun! ToggleMouse()
    if &mouse == ""
        let &mouse = "a"
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let &mouse = ""
        echo "Mouse is for Vim (" . &mouse . ")"
    endif
endfunction

"开关YankRing剪贴板缓冲区
nnoremap <F10> :YRShow<CR>

"使用F12切换鼠标模式
noremap <F12> :call ToggleMouse()<CR>
inoremap <F12> <Esc>:call ToggleMouse()<CR>a

" With a map leader it's possible to do extra key combinations
    let mapleader=","

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"快速退出vim
    nnoremap <C-c> :qall!<CR>

"搜索相关的设置
    set showmatch  " show matching brackets/parenthesis
    set magic      " 根据vim说明默认开启此参数
    set ignorecase " 忽略大小写
    set smartcase  " case sensitive when uc present

    "清空搜索结果高亮显示
    nnoremap <leader>/ :nohlsearch<CR>

"Window navigation mappings
"deprecated after using vim-tmux-navigator
    " noremap <C-h> <C-w>h
    " noremap <C-j> <C-w>j
    " noremap <C-k> <C-w>k
    " noremap <C-l> <C-w>l

"Tab navigation mappings
    map tn :tabn<CR>
    map tp :tabp<CR>
    map tm :tabm
    map tt :tabnew<cr>
    map ts :tab split<CR>
    map <C-S-Right> :tabn<CR>
    imap <C-S-Right> <ESC>:tabn<CR>
    map <C-S-Left> :tabp<CR>
    imap <C-S-Left> <ESC>:tabp<CR>

"Code View Mode
    fun! ToggleCodeViewMode()
        if !exists("s:codeviewmode")
            let s:codeviewmode = "0"
        endif

        if s:codeviewmode == "0"
            nmap j jzz
            nmap k kzz
            let s:codeviewmode = "1"
            echo "Code View Mode"
        else
            unmap j
            unmap k
            let s:codeviewmode = "0"
            echo "Code Edit Mode"
        endif
    endfunction
    command! CodeReview :call ToggleCodeViewMode()

" set text wrapping toggles
    nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
    nmap <silent> <leader>c <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" 在命令行里面, 用%%表示当前文件路径
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" 使用系统剪贴板复制粘帖(仅用于Mac)
    map <leader>y "+y
    map <leader>p "+p

" command mode, ctrl-a to head， ctrl-e to tail
	cnoremap <C-j> <t_kd>
	cnoremap <C-k> <t_ku>
	cnoremap <C-a> <Home>
	cnoremap <C-e> <End>

"代码折叠相关配置
"    set foldmethod=syntax       "代码折叠 共有6中方式如下
        "1. manual 手工定义折叠
        "2. indent 用缩进表示折叠
        "3. expr　 用表达式来定义折叠
        "4. syntax 用语法高亮来定义折叠
        "5. diff   对没有更改的文本进行折叠
        "6. marker 用标志折叠

"设置菜单和帮助的语言，默认改为英语
    set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
    set encoding=utf8
    set langmenu=en_US.UTF-8
    language message en_US.UTF-8
    let $LC_ALL='en_US.UTF-8'
    let $LANG='en_US.UTF-8'

"pathogen是Vim用来管理插件的插件
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect('bundle/{}', '~/.vim/bundle/{}')

"colorscheme配色方案配置
    "Config of colorscheme is in $HOME/.vimrc

" Airline ------------------------------
    let g:airline_powerline_fonts = 1
    let g:airline_detect_paste=1
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#syntastic#enabled = 0
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'

    " to use fancy symbols for airline, uncomment the following lines and use a
    " patched font (more info on the README.rst)
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    "let g:airline_symbols.crypt = '🔒'
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.branch = '⎇'
    "let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    "let g:airline_symbols.whitespace = 'Ξ'

    " powerline symbols
    "let g:airline_left_sep = ''
    "let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = ''
    "let g:airline_right_alt_sep = ''
    "let g:airline_symbols.branch = ''
    "let g:airline_symbols.readonly = ''
    "let g:airline_symbols.linenr = ''

 "CtrlP
    nnoremap <silent> <space><space> :CtrlPMixed<cr>
    nnoremap <silent> <space>f :CtrlP<cr>
    nnoremap <silent> <space>b :CtrlPBuffer<cr>
    nnoremap <silent> <space>t :CtrlPTag<cr>

    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    if executable('ag')
        " Use Ag over Grep
        set grepprg=ag\ --nogroup\ --nocolor

        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
            \ --ignore .git
            \ --ignore .svn
            \ --ignore .hg
            \ --ignore .DS_Store
            \ --ignore "**/*.pyc"
            \ -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    endif

"Ack选项
    let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-file=is:tags --ignore-file=ext:taghl --ignore-file=ext:out"

"Tagbar配置
    let g:tagbar_width=26
    let g:tagbar_autofocus = 1
    noremap <silent> <F4> :TagbarToggle<CR>

"NerdTree配置
    map <F3> :NERDTreeToggle<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.o','\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=2     "setting root dir in NT also sets VIM's cd
    let NERDTreeQuitOnOpen=0 "the Nerdtree window will be close after a file is opend.
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1

"rainbow配置
    let g:rainbow_conf = {
    \	'guifgs': ['RoyalBlue3', 'SeaGreen3', 'DarkOrchid3', 'firebrick3', 'darkorange3'],
    \	'ctermfgs': ['red','darkred','darkcyan','darkgreen','Darkblue','darkmagenta','gray','brown','darkmagenta','darkred','darkcyan','darkgreen','darkgray','Darkblue','brown'],
    \	'operators': '_,_',
    \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \	'separately': {
    \		'*': {},
    \		'lisp': {
    \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \		},
    \		'tex': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \		},
    \		'vim': {
    \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \		},
    \		'xml': {
    \			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
    \		},
    \		'xhtml': {
    \			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
    \		},
    \		'html': {
    \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \		},
    \		'php': {
    \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold', 'start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop'],
    \		},
    \		'css': 0,
    \	}
    \}

    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

"Fugitive配置
    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <Leader>gr :Gremove<CR>
    "nnoremap <Leader>gl :Glog<CR>
    nnoremap <Leader>gb :Gblame<CR>
    nnoremap <Leader>gm :Gmove
    nnoremap <Leader>gp :Ggrep
    nnoremap <Leader>gR :Gread<CR>
    nnoremap <Leader>gg :Git
    nnoremap <Leader>gd :Gdiff<CR>

"vim-go & gotags config
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    if executable('goimports')
        let g:go_fmt_command = "goimports"
    endif

    let g:go_fmt_autosave = 1

    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

"CompletePlugin
    source ~/.vim/vimrc-completeplugin.vim

"UltiSnips(Compatible with YouCompleteMe)
    let g:UltiSnipsExpandTrigger="<c-k>"
    let g:UltiSnipsJumpForwardTrigger="<c-k>"
    let g:UltiSnipsJumpBackwardTrigger="<c-j>"

"YCM-Generator
    "Usage in VIM:
    "      :YcmGenerateConfig to generate .ycm_extra_conf.py in work dir.
    "Usage in shell:
    "      ~/.vim/bundle/YCM-Generator/config_gen.py PROJECT_DIR

"easymotion
    let g:EasyMotion_smartcase  = 1 " Turn on case insensitive feature

    " Note: The default leader has been changed to <Leader><Leader> to avoid
    "       conflicts with other plugins you may have installed
    " Default Mapping      | Details
    " ---------------------|----------------------------------------------
    " <Leader>f{char}      | Find {char} to the right. See |f|.
    " <Leader>F{char}      | Find {char} to the left. See |F|.
    " <Leader>t{char}      | Till before the {char} to the right. See |t|.
    " <Leader>T{char}      | Till after the {char} to the left. See |T|.
    " <Leader>w            | Beginning of word forward. See |w|.
    " <Leader>W            | Beginning of WORD forward. See |W|.
    " <Leader>b            | Beginning of word backward. See |b|.
    " <Leader>B            | Beginning of WORD backward. See |B|.
    " <Leader>e            | End of word forward. See |e|.
    " <Leader>E            | End of WORD forward. See |E|.
    " <Leader>ge           | End of word backward. See |ge|.
    " <Leader>gE           | End of WORD backward. See |gE|.
    " <Leader>j            | Line downward. See |j|.
    " <Leader>k            | Line upward. See |k|.
    " <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
    " <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
    " <Leader>s            | Find(Search) {char} forward and backward.
    "                      | See |f| and |F|.

"undotree
    function! s:get_undotree_dir() "{{{
        let s:undotree_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'undotree_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/undotree' : expand('~/.cache/undotree'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:undotree_dir)
            call mkdir(s:undotree_dir, 'p')
        endif

        return s:undotree_dir
    endfunction"}}}

    nnoremap <F8> :UndotreeToggle<cr>
    if has("persistent_undo")
        let s:undotree_dir = "~/.cache/undotree"
        call s:get_undotree_dir()
        let &undodir = s:undotree_dir
        set undofile
    endif

"vim-multiple-cursors
    " Called once right before you start selecting multiple cursors
    " Only use with neocomplcache
    if g:my_complete_plugin == "neocomplcache"
        function! Multiple_cursors_before()
          if exists(':NeoComplCacheLock')==2
            exe 'NeoComplCacheLock'
          endif
        endfunction

        " Called once only when the multiple selection is canceled (default <Esc>)
        function! Multiple_cursors_after()
          if exists(':NeoComplCacheUnlock')==2
            exe 'NeoComplCacheUnlock'
          endif
        endfunction
    endif

    "If you don't like the plugin taking over your favorite key bindings, you
    "can turn off the default with
    let g:multi_cursor_use_default_mapping=0

    " Default mapping
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

    "By default, the 'next' key is also used to enter multicursor mode. If you
    "want to use a different key to start multicursor mode than for selecting
    "the next location, do like the following:
    " Map start key separately from next key
    let g:multi_cursor_start_key='<F9>'

    "Note that when multicursor mode is started, it selects current word with
    "boundaries, i.e. it behaves like *. If you want to avoid word boundaries in
    "Normal mode (as g* does) but still have old behaviour up your sleeve, you can
    "do the following
    "let g:multi_cursor_start_key='<C-n>'
    let g:multi_cursor_start_word_key='g<C-n>'

    "You can also map your own keys to quit, if g:multi_cursor_quit_key won't
    "work:
    "let g:multi_cursor_quit_key='<C-c>'
    "nnoremap <C-c> :call multiple_cursors#quit()<CR>

"vim-expand-region
    "Press '+' to expand the visual selection and '_' to shrink it.

"vim-exchange
    "Press 'X' to exchange between block in visual mode

"vim-better-whitespace
    "need this hack code to make everything OK now
    autocmd VimEnter * DisableWhitespace
    autocmd VimEnter * EnableWhitespace
    map <leader><space> :StripWhitespace<CR>

"indentLine
    " let g:indentLine_char = '┆'
    let g:indentLine_char = '¦'

"vim-visual-star-search
    "This plugin allows you to select some text using Vim's visual mode, then hit
    "* and # to search for it elsewhere in the file
    "If you hit <leader>* (\* unless you changed the mapleader), vim recursively
    "vimgreps for the word under the cursor or the visual selection.

"统一swapdir&backupdir
    function! s:get_swap_dir() "{{{
        let s:swap_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'swap_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/swap_dir' : expand('~/.cache/swap_dir'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:swap_dir)
            call mkdir(s:swap_dir, 'p')
        endif

        return s:swap_dir
    endfunction"}}}

    let s:swap_dir = "~/.cache/swap_dir//"
    call s:get_swap_dir()
    "let &directory = s:swap_dir
    "为了实现同名文件可以同时存在swapfile，先写死
    set directory=~/.cache/swap_dir//
    set backupdir=~/.cache/swap_dir//

" YankRing 剪贴板增量，支持256个最近剪贴
    function! s:get_yankring_dir() "{{{
        let s:yankring_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'yankring_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/yankring_dir' : expand('~/.cache/yankring_dir'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:yankring_dir)
            call mkdir(s:yankring_dir, 'p')
        endif

        return s:yankring_dir
    endfunction"}}}

    let s:yankring_dir = "~/.cache/yankring_dir//"
    call s:get_yankring_dir()

    let g:yankring_history_dir="~/.cache/yankring_dir//"
    let g:yankring_max_history=512
    let g:yankring_replace_n_pkey = '<leader>['
    let g:yankring_replace_n_nkey = '<leader>]'

"gv.vim 查看gitlog
    nnoremap <Leader>gl :GV<CR>

"vim-plist
    let g:plist_display_format = 'xml'
    let g:plist_save_format = ''

"vim-json
    let g:vim_json_syntax_conceal = 0

"cscope setting
    function! AddScope()
        " set csprg=/usr/local/bin/cscope
        " set cscopetagorder=1
        " set cscopetag
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        endif
        set csverb
    endfunction

    function! GenerateScope()
        !find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.java" -o -name "*.php" -o -name "*.go"> cscope.files;cscope -bkq -i cscope.files
        call AddScope()
    endfunction

    if has("cscope")
        call AddScope()
    endif

    " The following maps all invoke one of the following cscope search types:
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"nerdtree-git-plugin
    let g:NERDTreeUpdateOnCursorHold = 0

"vim-cpp-enhanced-highlight
    let g:cpp_class_scope_highlight = 1

"Toggle quickfix
    function! s:GetBufferList()
        redir =>buflist
        silent! ls
        redir END
        return buflist
    endfunction

    function! ToggleQuickfixList()
        for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
            if bufwinnr(bufnum) != -1
                cclose
                return
            endif
        endfor
        copen
    endfunction

    nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

"vim-gitgutter
    let g:gitgutter_realtime = 0
    let g:gitgutter_eager = 0

"自定义命令
command! Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
command! Gotags !gotags -R . >tags
command! Phptags !phpctags -R .
command! Cscope call GenerateScope()

command! Hex %!xxd
command! Asc %!xxd -r

command! Cswp !rm -f ~/.cache/swap_dir/*


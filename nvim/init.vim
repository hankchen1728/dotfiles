lua require("options")
" { Basic } {{{
    syntax enable
    syntax sync fromstart
    set synmaxcol=150
    set autochdir                          " automatically change to the directory of the file opened
    set conceallevel=2                     " concealment
    set cursorline                         " hightline the current line
    set diffopt+=iwhite                    " ignore white space in vimdiff
    set hidden                             " hidden unsaved buffers instead of closing them
    set history=1000
    set mouse=a                            " enable mouse
    set number relativenumber              " show line number
    set previewheight=5                    " hight of completion preview
    set pumheight=10                       " height of pop-up menu
    set re=1
    set showmatch                          " match parentheses
    set signcolumn=yes
    set timeout timeoutlen=400             " set timeout to use double key in imap confortablely
    set updatetime=300
    set virtualedit=block
    set wrap                               " line wrap
    " set ambiwidth=double       " Double char width

    set termguicolors
    set guifont=DroidSansMono\ Nerd\ Font:h18

    " { nvim-defaults } {{{
        " filetype plugin indent on              " Enable by default
        " set backspace=indent,eol,start
        " set encoding=utf-8
        " set showcmd                            " show uncomplete command
        " set wildmenu                           " command line completion
    "}}}

    " { Clipboard }{{{
        if has('clipboard')
            if has('unnamedplus') " + register
                set clipboard=unnamed,unnamedplus
            else " On mac and Windows, use * register for copy-paste
                set clipboard=unnamed
            endif
        endif
    " }}}

    " { Lazyredraw } {{{
        " For dealing slowly connection or updating
        " redraw only in need
        set nolazyredraw
        " autocmd InsertLeave * set lazyredraw
        " autocmd InsertEnter * set nolazyredraw

        function! ToggleLazyRedraw()
            exec 'set lazyredraw!'
            if &lazyredraw == 0
                echo 'LazyRedraw off'
            else
                echo 'LazyRedraw on'
            endif
        endfunction
        nnoremap <Space>cr :call ToggleLazyRedraw()<CR>
    " }}}

    " { Tab/spaces } {{{
        set expandtab              " expand tab to spaces
        " set smarttab               " [default] use shiftwidth instead of tabstop at start of lines
        set tabstop=4              " set tab to 4-spaces-wide
        set softtabstop=4          " set tab to 4-spaces-wide when editing
        set shiftwidth=4           " < and > will shift 4 spaces

    " }}}

    " { Indent mode } {{{
        " set autoindent    " enable by default
        set smartindent
    " }}}

    " { Completion } {{{
        " for nvim-compe setting
        set completeopt-=preview

        " Filename insert completion
        inoremap <C-f> <C-x><C-f>
    "}}}

    " { spell check }{{{
        set nospell
        setlocal spelllang=en_us,cjk
    "}}}

    " scroll offset(line numbers)
    if !&scrolloff
        set scrolloff=5
    endif

" }}}

" { filetype plugin }{{{

    " vim-python
    " augroup vimrc-python
    "   autocmd!
    "   autocmd FileType python setlocal colorcolumn=79 textwidth=79
    " augroup END

    " less space
    autocmd FileType csh,zsh,sh,tmux setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType lua,yaml,json,json5,html,tex setlocal tabstop=2 softtabstop=2 shiftwidth=2
"}}}

" { Windows/Buffers settings } {{{

    " jump between buffers
    nnoremap <Space><Tab> :b#<CR>

    " resizing
    nnoremap = <C-w>+
    nnoremap - <C-w>-
    nnoremap _ <C-w><
    nnoremap + <C-w>>

    " navigation
    nnoremap <Space>h     <C-w>h
    nnoremap <Space>l     <C-w>l
    nnoremap <Space>j     <C-w>j
    nnoremap <Space>k     <C-w>k
    " nnoremap <Tab>        <C-w><C-p>
    nnoremap <Space>e     <C-w><C-p>

    " split window
    set splitbelow splitright " specify the location
    nnoremap <Space>s :vsp \| b<Space>

" }}}

" { Plugins } {{{
" lua require'pluginList'
" }}}

" { Color } {{{
    " { ExtraWhitespace } {{{
        " highlight ExtraWhitespace ctermbg=239 guibg=Grey
        " autocmd BufEnter * if &ft != 'help' | match ExtraWhitespace /\s\+$/ | endif
        " autocmd BufEnter * if &ft == 'help' | match none /\s\+$/ | endif
    " }}}
" }}}

" { Search } {{{
    " set hlsearch         " highlight search
    " set incsearch        " incremental search

    set ignorecase       " ignore case during search
    set smartcase        " ignore case if search pattern is all lowercase
    set wildignorecase   " ignore case when doing completion

    nnoremap ss *        " search the current selected word under cursor

    " next/previous search
    vnoremap 0 n
    vnoremap 9 N
    vnoremap n y/<C-r>"<CR>
    vnoremap N y/<C-r>"<CR>NN
    vnoremap C y/<C-r>"<CR>Ncgn

    " grep search and show on quickfix
    vnoremap <C-f> y:vimgrep <C-r>" %<CR> \| :copen <CR>
    nnoremap <C-f> :vimgrep <C-r>/ %<CR> \| :copen <CR>

    " search/substitute
    vnoremap S :s///gc<Left><Left><Left><Left>
" }}}

" { Folding } {{{
    set foldenable                                           " default folding

    " default foldmethod
    set foldmethod=expr

    " use treesitter as folding method
    set foldexpr=nvim_treesitter#foldexpr()

    " hi SymbolFold ctermfg=44 guifg=#00d7d7
    " sign define foldLine text=  texthl=SymbolFold

    " folding display text
    set fillchars=fold:\ " use trailing space as the padding of folding
    set foldtext=MyFoldText()
    function! MyFoldText()
        " place a sign at start line
        let folded_line_num = v:foldend - v:foldstart
        " exec ":sign place 2 name=foldLine line=" . v:foldstart
        let head = getline(v:foldstart)
        let head = substitute(head, '{{{', '', 'g')
        let head = substitute(head, '\s\+$', '', 'g')
        let tail = substitute(trim(getline(v:foldend)), '.*}}}', '', 'g')
        let fillcharcount = &textwidth - len(head) - len(tail) - 5 - len(folded_line_num)
        return head . ' ... ' . tail . ' ' . repeat('-', fillcharcount) . ' (' . folded_line_num . ' L)'
    endfunction

    " Open the folding automatically in conditions of
    "   all             any
    "   block           (, {, [[, [{, etc.
    "   hor             horizontal movements
    "   insert          any command in Insert mode
    "   jump            far jumps
    "   mark            mark jumps
    "   percent         pair match
    "   quickfix        :cn, :crew, :make, etc.
    "   search          search for a pattern: /, n, *, gd, etc.
    "                   (not for a search pattern in a : command) Also for [s and ]s.
    "   tag             jumping to a tag: :ta, CTRL-T, etc.
    "   undo            undo or redo: u and CTRL-R
    set foldopen=hor,mark,percent,quickfix,search,tag,undo

    " fold methods for different filetypes
    autocmd FileType tmux,csh,zsh,snippets setlocal foldenable foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType json,json5 setlocal foldenable foldmethod=syntax

    function! FoldOrSelect()
        if foldlevel(line('.')) == 0
            call feedkeys("vip")
        else
            call feedkeys("za")
        endif
    endfunction

    " Press TAB to toggle folding except in quickfix
    nnoremap <expr> <TAB> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"

    " Press TAB to create folding
    vnoremap <TAB> zf
" }}}

" { Buffer saving/loading/exit } {{{
    " auto save and restore
    set vop=folds,cursor,curdir  " save folds, cursor position, working directory only
    let blacklist = ['qf']
    autocmd BufWinLeave ?* if index(blacklist, &ft) < 0 | mkview
    autocmd BufRead ?* if index(blacklist, &ft) < 0 | silent! loadview

    " FIXME: auto start LSP
    " autocmd BufEnter ?* if index(blacklist, &ft) < 0 | LspStart

    " Auto search and clean trailing space after file written.
    autocmd BufWritePre * %s/\s\+$//e

    " save and (force) exit
    noremap Q :q<CR>
    noremap ! :q!<CR>
    " noremap X :x<CR>
    nnoremap <Space>w :w<CR>
    " nnoremap <Space>x :x<CR>
    autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | bdelete | endif

    function! QuitOrBufferDelete()
        let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
        let empty_name = (expand('%') == '')
        if (buf_len && empty_name)
            exec 'q'
        else
            exec 'bd'
        endif
    endfunction
    nnoremap <silent> <Space>q :call QuitOrBufferDelete()<CR>

" }}}

" { Mappings }{{{
lua require("mappings")
    " paste setting (toggles the 'paste' option)
    set pastetoggle=<F2>

    inoremap aa <C-o>a

    " { Disable arrow keys } {{{

        " normal mode
        nnoremap <Down> <Nop>
        nnoremap <Left> <Nop>
        nnoremap <Right> <Nop>
        nnoremap <Up> <Nop>

        " insert mode
        " disable the affect of `^[OA` when pressing <up> in insert mode
        " imap <ESC>oA <ESC>ki
        " imap <ESC>oB <ESC>ji
        " imap <ESC>oC <ESC>li
        " imap <ESC>oD <ESC>hi
        inoremap <Down> <Nop>
        inoremap <Left> <Nop>
        inoremap <Right> <Nop>
        inoremap <Up> <Nop>

    "}}}

    " { Redo / Undo } {{{
        nnoremap U <C-r>
        inoremap uu <Esc>u
    "}}}

    " { Movement with in line } {{{
        " begining & end
        nnoremap B ^
        nnoremap E $
        vnoremap B ^
        vnoremap E $h

        " emacs-like
        inoremap <M-f> <C-o>w
        inoremap <M-b> <C-o>b
        inoremap <C-a> <C-o>I
        inoremap <C-e> <C-o>A
        " cnoremap <C-f> <Right>
        " cnoremap <C-o> <C-f>
        " cnoremap <C-b> <Left>
    " }}}

    " { Last changed } {{{
        nnoremap g; g;zz
        nnoremap g, g,zz
        nnoremap <C-o> <C-o>zz
    "}}}

    " { Command mode mapping } {{{
        cnoremap <M-b>    <S-Left>
        cnoremap <M-f>    <S-Right>
        cnoremap <C-a>    <Home>
        cnoremap <C-e>    <End>
    "}}}

    " { Dragging line vertically } {{{
        nnoremap <C-u> :m .-2<CR>
        nnoremap <C-d> :m .+1<CR>
        inoremap <C-u> <Esc>:m .-2<CR>gi
        inoremap <C-d> <Esc>:m .+1<CR>gi
        vnoremap <C-u> :m '<-2<CR>gv=gv
        vnoremap <C-d> :m '>+1<CR>gv=gv
    " }}}

    " { Dragging line horizontally } {{{
        nnoremap > >>
        nnoremap < <<

        " indent and re-select
        vnoremap > >gv
        vnoremap < <gv
    " }}}

    " { Escape key mapping } {{{
        " nnoremap q  <Esc>
        nnoremap qq <Esc>
        vnoremap q  <Esc>
        inoremap qq <Esc>
        inoremap qw <Esc>:w<CR>
        " inoremap <C-[> <Esc>
    " }}}

    " { Page scrolling }{{{
        nnoremap <C-k> <C-u>                " page up
        nnoremap <C-j> <C-d>                " page down

        " movement in too long lines
        nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
        nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
    "}}}

    " toggle the 'virtualedit'
    " nmap ve :let &virtualedit=&virtualedit=="" ? "all" : "" \| set virtualedit?<CR>

    " toggle highlight search
    nnoremap <Space>f :set hlsearch! hlsearch?<CR>

    " split window
    nnoremap <Space>s :vsp \| b<Space>

    " Switch Buffer in Normal mode
    nnoremap <space>n :bn<CR>
    nnoremap <space>p :bp<CR>
    nnoremap <Leader>bd :bdelete

    " list history of command
    noremap ;; q:

"}}}

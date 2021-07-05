" { Basic } {{{
    syntax on
    syntax sync fromstart
    set nocompatible
    set ruler                              " show file name, lines, etc.
    set showcmd                            " show uncomplete command
    set history=1000
    set showmode
    set autochdir                          " automatically change to the directory of the file opened
    set wildmenu                           " command line completion
    set cursorline                         " hightline the current line
    set number relativenumber              " show line number
    set showmatch                          " match parentheses
    set diffopt+=iwhite                    " ignore white space in vimdiff
    set timeout timeoutlen=400             " set timeout to use double key in imap confortablely
    " set updatetime=300
    set mouse=a                            " enable mouse
    set encoding=utf-8
    set hidden                             " hidden unsaved buffers instead of closing them
    set previewheight=5                    " hight of completion preview
    set pumheight=10                       " height of pop-up menu
    set wrap                               " line wrap
    set backspace=indent,eol,start
    set virtualedit=block
    set re=1
    set conceallevel=2                     " concealment
    set signcolumn=yes
    " set ambiwidth=double       " Double char width

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
        set smarttab               " use shiftwidth instead of tabstop at start of lines
        set tabstop=4              " set tab to 4-spaces-wide
        set softtabstop=4          " set tab to 4-spaces-wide when editing
        set shiftwidth=4           " < and > will shift 4 spaces

    " }}}

    " { Indent mode } {{{
        set autoindent
        set smartindent
        " set cindent
    " }}}

    " { Completion } {{{
        " for nvim-compe setting
        set completeopt-=preview

        " Filename insert completion
        inoremap <C-f> <C-x><C-f>
    "}}}

    " spell check
    setlocal spell spelllang=en_us
    set spell!

    " scroll offset(line numbers)
    if !&scrolloff
        set scrolloff=5
    endif
" }}}

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
    lua require'Plugins'
"}}}

" { Color } {{{
    set background=dark
    set synmaxcol=150
    set t_Co=256               " 256 colors
    " set term=xterm-256color

    colorscheme onedark
    hi Normal guibg=NONE ctermbg=NONE
    let g:onedark_termcolors = 256
    let g:onedark_terminal_italics = 1

    " let g:python_highlight_all = 1              " vim-python syntax highlight

    hi Search cterm=reverse ctermbg=none ctermfg=none             " Search match
    hi CursorLineNr cterm=bold ctermfg=Green ctermbg=none         " Cursor Line Number
    " hi CursorLine cterm=none ctermbg=094 ctermfg=none           " Cursor Line
    " hi String ctermfg=214
    hi Visual cterm=bold ctermbg=240 guibg=Grey                   " Selected block
    hi Folded ctermbg=233

    " High light unwanted spaces in end of line
    highlight ExtraWhitespace ctermbg=239 guibg=Grey
    autocmd BufEnter * if &ft != 'help' | match ExtraWhitespace /\s\+$/ | endif
    autocmd BufEnter * if &ft == 'help' | match none /\s\+$/ | endif

    " toggle highlight search
    nnoremap <Space>f :set hlsearch! hlsearch?<CR>
" }}}

" { Search } {{{
    set hlsearch         " highlight search
    set incsearch        " incremental search

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
    setlocal foldmethod=expr

    " use treesitter as folding method
    set foldexpr=nvim_treesitter#foldexpr()

    " folding display text
    set fillchars=fold:\               " use trailing space as the padding of folding
    set foldtext=MyFoldText()
    function! MyFoldText()
        let head = getline(v:foldstart)
        let head = substitute(head, '{{{', '', 'g')
        let head = substitute(head, '\s\+$', '', 'g')
        let tail = substitute(trim(getline(v:foldend)), '.*}}}', '', 'g')
        return head . ' ... ' . tail
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
    autocmd FileType tmux,zsh,snippets setlocal foldenable foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType json,json5 setlocal foldenable foldmethod=syntax
    " autocmd FileType python setlocal foldenable foldmethod=manual

    function! FoldOrSelect()
        if foldlevel(line('.')) == 0
            call feedkeys("vip")
        else
            call feedkeys("za")
        endif
    endfunction

    " Press TAB to toggle folding except in quickfix
    nnoremap <expr> <TAB> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"

    " Press Enter to create folding
    vnoremap <TAB> zf
" }}}

" { Mappings }{{{
    " paste setting (toggles the 'paste' option)
    nnoremap <silent> <F2> :set invpaste paste?<CR>
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
        nnoremap q  <Esc>
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
    nmap ve :let &virtualedit=&virtualedit=="" ? "all" : "" \| set virtualedit?<CR>

    " split window
    nnoremap <Space>s :vsp \| b<Space>

    " Switch Buffer in Normal mode
    nnoremap <Leader>bj :bn<CR>
    nnoremap <Leader>bk :bp<CR>
    nnoremap <Leader>bd :bdelete

    " list history of command
    noremap ;; q:

"}}}

" { Plugin Config } {{{
    " { vim-airline } {{{
        set laststatus=2                                           " set status line
        let g:airline_theme = 'ayu_dark'
        let g:airline_powerline_fonts = 1                          " enable powerline-fonts
        let g:airline_skip_empty_sections = 1
        let g:airline#extensions#bufferline#enabled = 1
        " let g:airline#extensions#tagbar#enabled = 1
        let g:airline#extensions#branch#enabled = 1                " Show current git branch
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#fnamemod = ':t'           " Show file name only
        let g:airline#extensions#tabline#show_tab_nr = 1
        let g:airline#extensions#tabline#tab_nr_type = 1
        let g:airline#extensions#tabline#buffer_nr_show=1          " Show the index of buffer
        let g:airline#extensions#tabline#buffer_idx_mode = 0

        nmap <leader>1 <Plug>AirlineSelectTab1
        nmap <leader>2 <Plug>AirlineSelectTab2
        nmap <leader>3 <Plug>AirlineSelectTab3
        nmap <leader>4 <Plug>AirlineSelectTab4
        nmap <leader>5 <Plug>AirlineSelectTab5
        nmap <leader>6 <Plug>AirlineSelectTab6
        nmap <leader>7 <Plug>AirlineSelectTab7
        nmap <leader>8 <Plug>AirlineSelectTab8
        nmap <leader>9 <Plug>AirlineSelectTab9

        let g:airline_symbols = get(g:, 'airline_symbols', {})
        let g:airline_symbols.space = "\ua0"

        " { powerline_fonts } {{{
            if !exists('g:airline_powerline_fonts')
                " unicode symbols
                let g:airline_left_sep = '»'
                let g:airline_left_sep = '▶'
                let g:airline_right_sep = '«'
                let g:airline_right_sep = '◀'
                let g:airline_symbols.crypt = '🔒'
                let g:airline_symbols.linenr = '☰ '
                let g:airline_symbols.maxlinenr = '㏑'
                let g:airline_symbols.branch = '⎇'
                let g:airline_symbols.spell = 'Ꞩ'
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.whitespace = 'Ξ'
            else
                " powerline symbols
                let g:airline_left_sep = ''
                let g:airline_left_alt_sep = ''
                let g:airline_right_sep = ''
                let g:airline_right_alt_sep = ''
                let g:airline_symbols.branch = ''
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.linenr = '☰ '
                let g:airline_symbols.colnr = ':'
                let g:airline_symbols.maxlinenr = ''
                let g:airline_symbols.dirty='⚡'
                let g:airline_symbols.delimiters = ' '
            endif
        " }}}
    " }}}
"}}}

"*****************************************************************************
""" Custom configs
"*****************************************************************************

filetype plugin indent on

" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
  " Multi-lines comment
  autocmd FileType python syntax region comment start=/"""/ end=/"""/
  autocmd FileType python syntax region comment start=/'''/ end=/'''/
augroup END


" less space
autocmd FileType lua,yaml,json,json5,html,tex setlocal tabstop=2 softtabstop=2 shiftwidth=2

" vim-airline
" let g:airline#extensions#virtualenv#enabled = 1

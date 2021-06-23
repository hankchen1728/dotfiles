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
    set timeout timeoutlen=600             " set timeout to use double key in imap confortablely
    set mouse=a                            " enable mouse
    set encoding=utf-8
    set hidden                             " hidden unsaved buffers instead of closing them
    set previewheight=5                    " hight of completion preview
    set wrap                               " line wrap
    set backspace=indent,eol,start
    set virtualedit=
    set re=1
    set conceallevel=2                     " concealment
    " nnoremap <Space>c :setlocal conceallevel=<c-r>=&conceallevel == 0 ? '2' : '0'<cr><cr>
    " set virtualedit=all        " allows spacing the cursor to any column
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

" { Vim-Plug } {{{
    " { install vim-plug } {{{
        let vimplug_exists=expand('~/.local/share/nvim/runtime/autoload/plug.vim')

        let g:vim_bootstrap_langs = "c,html,javascript,python,ruby"
        let g:vim_bootstrap_editor = "nvim"				" nvim or vim

        if !filereadable(vimplug_exists)
          if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            execute "q!"
          endif
          echo "Installing Vim-Plug..."
          echo ""
          silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          let g:not_finish_vimplug = "yes"

          autocmd VimEnter * PlugInstall
        endif
    "}}}

    call plug#begin('~/.local/share/nvim/plugged')
    " General
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'                                     " auto pair brackets, parens, quotes
    Plug 'tpope/vim-surround'                                       " auto surround brackets, parens, quotes

    Plug 'neovim/nvim-lspconfig'                                    " A collection of common configurations for Neovim's built-in language server client
    Plug 'nvim-compe'                                               " Auto completionlugin for nvim

    Plug 'majutsushi/tagbar'
    Plug 'tpope/vim-fugitive'                                       " git helper for vim
    Plug 'junegunn/limelight.vim'                                   " hyperfocus-writing in Vim
    Plug 'w0rp/ale'                                                 " linter
    Plug 'google/vim-searchindex'                                   " Search index helper
    Plug 'kalekundert/vim-coiled-snake'                             " folding tool
    Plug 'Konfekt/FastFold'
    Plug 'FooSoft/vim-argwrap'                                      " Wrap and unwrap function arguments, lists, and dictionaries in Vim.
    Plug 'ervandew/supertab'                                        " use <tab> to completion
    Plug 'Yggdroot/indentLine'                                      " indentline
    Plug 'scrooloose/nerdcommenter'                                 " vim plugin for intensely orgasmic commenting
    Plug 'blueyed/vim-diminactive'                                  " dim inactive windows

    " Colorscheme
    Plug 'joshdick/onedark.vim'                                     " Dark colorscheme

    " Syntax
    " Plug 'sheerun/vim-polyglot'                                     " Syntax highlight for various languages
    Plug 'kh3phr3n/python-syntax'                                   " Syntax highlight for python3

    " { Python } {{{
        Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
    "}}}

    " { Markdown } {{{
        Plug 'godlygeek/tabular', { 'for': 'markdown' }
        Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
        " Avoid lower vim version
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
        Plug 'iamcco/mathjax-support-for-mkdp'                      " mathjax support for markdown-preview.vim plugin
    " }}}

    " csv layout
    Plug 'chrisbra/csv.vim'

    call plug#end()
"}}}

" { Color } {{{
    set background=dark
    set synmaxcol=150
    set t_Co=256               " 256 colors
    " set term=xterm-256color

    colorscheme onedark
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

" { Completion } {{{
    " The tab trigger is done by SuperTab.

    " Use jedi-vim for python completion
    autocmd FileType python setlocal omnifunc=jedi#completions " completeopt-=preview " disable docstring preview window popup

    " Supertab
    let g:SuperTabDefaultCompletionType = "<c-n>"
    " let g:SuperTabLongestEnhanced = 1
    " let g:SuperTabCrMapping = 0

    " Press <Enter> to select the completion
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Filename insert completion
    inoremap <C-f> <C-x><C-f>
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
    " set nofoldenable                                           " default no folding
    " set foldmethod=manual
    set foldopen-=block

    " fold methods for different filetypes
    autocmd FileType tmux,zsh,snippets setlocal foldenable foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType json setlocal foldenable foldmethod=syntax
    autocmd FileType python setlocal foldenable foldmethod=manual

    " nnoremap zp vipzf                                          " fold the current paragraph
    function! FoldOrSelect()
        if foldlevel(line('.')) == 0
            call feedkeys("vip")
        else
            call feedkeys("za")
        endif
    endfunction

    " Press Enter to toggle folding except in quickfix
    nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"

    " Press Enter to create folding
    vnoremap <CR> zf
" }}}

" { Mappings }{{{
    " paste setting (toggles the 'paste' option)
    nnoremap <silent> <F2> :set invpaste paste?<CR>
    set pastetoggle=<F2>

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
    inoremap <C-[> <Esc>
" }}}

    " { Auto-pair }{{{
        let g:AutoPairsShortcutToggle = "<Space>p"
        " inoremap [ []<ESC>i
        " inoremap {<CR> {<CR>}<ESC>ko
        " inoremap { {}<ESC>i
        " inoremap ( ()<ESC>i

        " inoremap " ""<ESC>i
        " inoremap ' ''<ESC>i
    "}}}

    " { Page scrolling }{{{
        nnoremap <C-k> <C-u>                " page up
        nnoremap <C-j> <C-d>                " page down

        " movement in too long lines
        " nnoremap j gj
        " nnoremap k gk
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
        let g:airline#extensions#ale#enabled = 1                   " ALE syntax
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

    " { indentLine } {{{
        let g:indentLine_enabled = 0
        "let g:indentLine_setColors = 0
        let g:indentLine_color_term = 50
        let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    "}}}

    " { Limelight } {{{
        let g:limelight_conceal_ctermfg = 'gray'
        let g:limelight_conceal_ctermfg = 240
        let g:limelight_paragraph_span  = 1
    "}}}

    " { NERDCommenter } {{{
        let g:NERDSpaceDelims            = 1 " Add spaces after comment delimiters by default
        let g:NERDCommentEmptyLines      = 0
        let g:NERDCompactSexyComs        = 1 " Use compact syntax for prettified multi-line comments
        let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
        let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
        let g:NERDCustomDelimiters       = {'c':{'left':'//'}, 'python':{'left':'#'}, 'bash':{'left':'#'}}
    "}}}

    " { vim-argwrap } {{{
        nnoremap <silent> <Space>a :ArgWrap<CR>
        " let g:argwrap_tail_comma = 1              " preceded with a comma at last arg when wrapping lines.
    "}}}

    " vim-surround {{{
        let g:surround_no_mappings = 1
        nmap cs <Plug>Csurround
        nmap ds <Plug>Dsurround
        vmap s <Plug>VSurround
        vmap gs <Plug>VgSurround
    "}}}

    " { vim-diminactive } {{{
        " let g:diminactive_use_syntax = 1   " disable syntax highlight in inactive pane
        hi ColorColumn ctermbg=236 guibg=#eee8d5
    "}}}

    " { vim-markdown } {{{
        let g:vim_markdown_toc_autofit      = 1
        let g:vim_markdown_folding_disabled = 1
        let g:vim_markdown_no_default_key_mappings = 1
    "}}}

    " { vim-csv } {{{
        let g:csv_no_progress = 1
        let g:csv_strict_columns = 1
        let g:csv_start = 1
        let g:csv_end = 100
        let g:csv_nomap_up=1
        let g:csv_nomap_down=1
    "}}}

    " { virtualenv } {{{
        let g:virtualenv_auto_activate = 1
        let g:virtualenv_directory     = $VIRTUAL_ENV
    "}}}

    " { ale } {{{
        let g:ale_fixers = {
        \    'python': ['autopep8']
        \}
        let g:ale_python_autopep8_options = '-v -a -a -a --max-line-length=79'
        let g:ale_linters = {
        \   'python': ['flake8', 'pylint', 'mypy'],
        \   'zsh': ['shell'],
        \}
    "}}}

    " { Markdown preview } {{{
        let g:mkdp_auto_start = 0 				  " do NOT automatically open the preview window
        let g:mkdp_auto_close = 1 				  " auto close current preview window when change to another buffer
        let g:mkdp_refresh_slow = 0  			  " auto refresh markdown as you edit or move the cursor
        let g:mkdp_command_for_global = 0         " MarkdownPreview command can be use for only markdown file
        let g:mkdp_open_to_the_world = 1   		  " preview server available to others in your network
        let g:mkdp_open_ip = system("curl ifconfig.me")  " custom the server ip
        let g:mkdp_port = '8017'                  " use a custom port to start server
        let g:mkdp_browser = ''                   " no browser specified
        let g:mkdp_echo_preview_url = 1           " echo preview page url in command line when open preview page
        let g:mkdp_browserfunc = ''               " custom vim function name to open preview page
        let g:mkdp_page_title = '「${name}」'     " preview page title, default with filename
        let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {},
            \ 'flowchart_diagrams': {}
            \ }
    "}}}

    " { python-syntax } {{{
        let python_highlight_all = 1
        " let python_self_cls_highlight = 1
        " let python_no_operator_highlight = 1
        " let python_no_parameter_highlight = 0
    "}}}

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
  autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
  " Multi-lines comment
  autocmd FileType python syntax region comment start=/"""/ end=/"""/
  autocmd FileType python syntax region comment start=/'''/ end=/'''/
augroup END


" YAML
autocmd FileType yaml,json,json5 setlocal tabstop=2 softtabstop=2 shiftwidth=4

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Basic Configs
syntax on
filetype on
set nocompatible
set ruler                  " show file name, lines, etc.
set showcmd                " show uncomplete command
set history=200
set showmode
set autochdir              " automatically change to the directory of the file opened
set wildmenu               " command line completion
set cursorline             " hightline the current line
set number relativenumber  " show line number
set showmatch              " match parentheses
set diffopt+=iwhite        " ignore white space in vimdiff
set mouse=a                " enable mouse
set encoding=utf-8
set expandtab              " change tab to space
set smarttab               " add shiftwidth spaces at start of line
set tabstop=4              " set tab to 4-spaces-wide
set shiftwidth=4           " width of tab
set cindent                " auto indent
set hidden                 " hidden unsaved buffers instead of closing them
set wrap                   " line wrap
set backspace=indent,eol,start

" scroll offset(line numbers)
if !&scrolloff
    set scrolloff=5
endif

" paste setting (toggles the 'paste' option)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" color/colorscheme/syntax
set background=dark
set synmaxcol=150
set t_Co=256               " 256 colors
colorscheme monokai-bold

" conceal
set conceallevel=1
"nnoremap <Space>c :setlocal conceallevel=<c-r>=&conceallevel == 0 ? '2' : '0'<cr><cr>

set hlsearch " Highlight the search
hi Search cterm=reverse ctermbg=none ctermfg=none           " Search match
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=none       " Cursor Line Number
hi CursorLine cterm=none ctermbg=094 ctermfg=none           " Cursor Line
hi Comment ctermfg=087
hi String ctermfg=214
hi Visual cterm=bold ctermbg=Grey guibg=Grey40

" High light unwanted spaces in end of line
highlight ExtraWhitespace ctermbg=darkred guibg=darkcyan
autocmd BufEnter * if &ft != 'help' | match ExtraWhitespace /\s\+$/ | endif
autocmd BufEnter * if &ft == 'help' | match none /\s\+$/ | endif

" add comment
syntax region comment start=/"""/ end=/"""/
syntax region comment start=/'''/ end=/'''/

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,html,javascript,python,ruby"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

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

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" General use
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'                                       " git helper for vim
Plug 'w0rp/ale'

" Plug 'tpope/vim-commentary'                                   " comment stuff out
Plug 'scrooloose/nerdcommenter'                                 " vim plugin for intensely orgasmic commenting

" Python
"" Python Bundle
" Remember to install 'jedi' package in python3
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'ervandew/supertab'                                        " use <tab> to completion
Plug 'Yggdroot/indentLine'                                      " indectline
Plug 'jmcantrell/vim-virtualenv'

" Markdown
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" csv layout
Plug 'chrisbra/csv.vim'

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Folding
" set foldmethod=indent
set foldmethod=manual
nnoremap <space> za
vnoremap <space> zf

" ale
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
let g:ale_fixers = {
\    'python': ['autopep8']
\}
let g:ale_python_autopep8_options = '-v -a -a -a --max-line-length=79'
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'zsh': ['shell'],
\}

" vim-markdown
let g:vim_markdown_no_default_key_mappings = 1

" NERDTree
nnoremap <silent> <F5> :NERDTree<CR>

"*****************************************************************************
"" Visual Setting
"*****************************************************************************




"*****************************************************************************
"" Plug setting
"*****************************************************************************
" Hotkey of opening NERDTree

" vim-airline
set laststatus=2                                           " set status line
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1                          " enable powerline-fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show=1          " Show the index of buffer
let g:airline#extensions#bufferline#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_symbols.space = "\ua0"

" if !exists('g:airline_powerline_fonts')
" unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'PASTE'
  " let g:airline_symbols.paste = 'ρ'
  " let g:airline_symbols.paste = 'Þ'
  " let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'
" else
" powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.dirty='⚡'
" endif

" indentLine
let g:indentLine_enabled = 0
"let g:indentLine_setColors = 0
let g:indentLine_color_term = 50
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" NERDCommenter
let g:NERDSpaceDelims            = 1 " Add spaces after comment delimiters by default
let g:NERDCommentEmptyLines      = 0
let g:NERDCompactSexyComs        = 1 " Use compact syntax for prettified multi-line comments
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDDefaultAlign           = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCustomDelimiters       = {'c':{'left':'//'}, 'python':{'left':'#'}, 'bash':{'left':'#'}}

" vim-markdown
let g:vim_markdown_toc_autofit      = 1
let g:vim_markdown_folding_disabled = 1

" virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_directory     = $VIRTUAL_ENV

" jedi-vim
let g:jedi#force_py_version = 3
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "2"
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#completions_command = "<C-N>"
let g:jedi#smart_auto_mappings = 0
let g:SuperTabDefaultCompletionType = "context"

autocmd FileType python set omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview " disable docstring preview window popup

" Markdown preview
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

"*****************************************************************************
""" Custom configs
"*****************************************************************************
" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" YAML
" au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

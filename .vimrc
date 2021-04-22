" VIM Config
" @see https://blog.joren.ga/tools/vim-learning-steps
" Build-in improve % option (works with if statements)
" runtime macros/matchit.vim

" @see https://vim.fandom.com/wiki/Example_vimrc
" @see https://vim.fandom.com/wiki/Best_Vim_Tips
" @see https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/
" @See :h quickref
set nomodeline                                                       " Security!
set secure                                                           " Security!: Not autocmd in .vimrc file
set exrc                                                             " Always search config in .vimrc file
set hidden                                                           " Allow change between buffer without save
set wildmenu                                                         " Autocomplete in command-line with <Tab>
set wildmode=full                                                    " Command complete as zsh"
set wildignore+=.git,.vscode,.idea,.vimrc,                           " Ignored files in command-line autocomplete
set wildignore+=*.zip,*.tar,*.tar.gz,*.gz,
set wildignore+=*.log,*/tmp/*,*.so,*.swp,*~,._*,
set wildignore+=*.jpg,*.png,*.gif,*.jpeg,
set wildignore+=node_modules,vendor,*/coverage/*,
set lazyredraw                                                       " No redraw when macro is running
set redrawtime=3000                                                  " Time for highlighting: +size need +time
set nobackup
set nowritebackup
set noswapfile
set path=.,,

set sessionoptions+=globals
set sessionoptions-=buffers
set sessionoptions-=options
set sessionoptions-=terminal
set viewoptions-=options

" Better Search
set hlsearch
set incsearch
set smartcase
set ignorecase
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
    set grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ \ %l%m
endif

" Tell vim to remember certain things when we exit
" @see https://vimhelp.org/options.txt.html#%27viminfo%27
" set viminfo=!,'20,<50,s10,h                                          " TODO: Session not works

" Better Completion
" @see :h 'complete'
set complete-=i
set complete=.,w,b
set completeopt=longest,menuone,preview

" Custom Interface
set title
set novisualbell
set autoread
set autowrite
set backspace=indent,eol,start
set clipboard=unnamedplus
set splitbelow
set splitright
set signcolumn=yes
set pumheight=15

if has('mouse')
    set mouse=
endif

" Custom Render
syntax enable
set nowrap
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
set nojoinspaces

" Custom View
set number
set numberwidth=1
set relativenumber
set cursorline
set noshowmatch
set matchtime=0
set list
set listchars=space:·,tab:»-
set colorcolumn=121
" set textwidth=120
set synmaxcol=200
set winminheight=0
set winheight=999
set updatetime=300

" Custom identation
" set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab
set fileformat=unix

" Enable folding : Hit za
set nofoldenable
set foldmethod=indent
set foldnestmax=10
set foldlevel=99

execute 'augroup Freddie'
autocmd!

" Statusline
let g:currentmode={
    \ 'c'     : 'COMMAND  ',
    \ 'i'     : 'INSERT   ',
    \ 'ic'    : 'INSERT   ',
    \ 'ix'    : 'INSERT   ',
    \ 'n'     : 'NORMAL   ',
    \ 'multi' : 'MULTIPLE ',
    \ 'ni'    : 'NORMAL   ',
    \ 'no'    : 'NORMAL   ',
    \ 'R'     : 'REPLACE  ',
    \ 'Rv'    : 'R-VIRTUAL',
    \ 's'     : 'SELECT   ',
    \ 'S'     : 'S-LINE   ',
    \ ''    : 'S-BLOCK  ',
    \ '!'     : 'SHELL    ',
    \ 't'     : 'TERMINAL ',
    \ 'v'     : 'VISUAL   ',
    \ 'V'     : 'V-LINE   ',
    \ ''    : 'V-BLOCK  ',
    \}

function! ChangeStatuslineColor() abort
    try
        if (mode() =~# '\v(n|no|ni|c)')
            execute "highlight! link StatusLine LineNr"
        elseif (mode() =~# '\v^i')
            execute "highlight! StatusLine cterm=reverse guifg=#84A598 guibg=#1D2021"
        elseif (mode() =~# '\v^R')
            execute "highlight! StatusLine cterm=reverse guifg=#8FBF7F guibg=#1D2021"
        elseif (mode() =~# '\v(v|V|t|!)' || g:currentmode[mode()] ==# 'V-BLOCK  ')
            execute "highlight! StatusLine cterm=reverse guifg=#FC802D guibg=#1D2021"
        elseif (mode() =~# '\v(s|S)' || g:currentmode[mode()] ==# 'S-BLOCK  ')
            execute "highlight! StatusLine cterm=reverse guifg=#D3869B guibg=#1D2021"
        else
            echomsg 'Mode no color: ' . mode()
            execute "highlight! StatusLine cterm=reverse guifg=#FB4934 guibg=#1D2021"
        endif

        silent redraw
    catch
        let &readonly = &readonly
    endtry

    return ''
endfunction

function! s:get_branch() abort
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

    return strlen(l:branchname) > 0 ? l:branchname : ''
endfunction

set showcmd
set noruler
set noshowmode
set shortmess+=WFAIcat
set shortmess-=S
set laststatus=2

set statusline=
set statusline+=%{ChangeStatuslineColor()}
set statusline+=\ %n
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=\ %f
set statusline+=%=
set statusline+=\%m
set statusline+=\%r
set statusline+=\ %3{&filetype}
set statusline+=\ #:%3b
set statusline+=\ l:%3l/%3L\ c:%3c
set statusline+=\%<\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ @\ %{strftime(\"%H:%M\")}

" Maps
let &t_TI = ''
let &t_TE = ''
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
noremap <Space> <Nop>

" Indent without kill the selection in visual mode
vmap < <gv
vmap > >gv
vmap . :normal! .<Enter>

" Purify
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Arrow keys resize windows
nnoremap <Up> :resize -10<Enter>
nnoremap <Down> :resize +10<Enter>
nnoremap <Left> :vertical resize -10<Enter>
nnoremap <Right> :vertical resize +10<Enter>

" Utility
nnoremap j gj
nnoremap k gk
nnoremap Q @@
nnoremap Y y$
nnoremap gl '.
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
map <silent> <Leader><Esc> :call popup_clear(1)<Enter>

" Sudo rescue
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <Bar> edit!

" Visual / Select and Normal Mode
noremap <Leader>s <kDivide>
noremap <Leader>S ?
noremap <silent> <F10> :if expand('%:t:r') == '.vimrc'<Enter> :PlugUpdate<Enter> :else<Enter> :edit ~/.vimrc<Enter> :endif<Enter><Enter>
noremap <silent> <Enter> :nohlsearch<Enter>
noremap <silent> TT _vg_

" Normal Mode
nnoremap <silent> <Leader>c "_c
nnoremap <silent> <Leader>d "_d
nnoremap <silent> <Leader>x "_x
nnoremap <silent> <Leader>y "+y

nnoremap <silent> <Leader>w :update<Enter>
nnoremap <silent> <Leader>W :wall<Enter> :echo 'All saved!'<Enter>

nnoremap <silent> <Leader>n :echo 'File: ' . expand('%:p')<Enter>
nnoremap <silent> <Leader>N :let @+=expand('%:p')<Enter> :echo 'Copied: ' . expand('%:p')<Enter>

nnoremap <silent> <Leader>f :call <SID>find_filter('e')<Enter>
nnoremap <silent> <Leader>F :call <SID>find_filter('w')<Enter>
vnoremap <silent> <Leader>f :<C-u>call <SID>find_filter(visualmode())<Enter>

nnoremap <silent> <Leader>z :if !&filetype<Enter> :bwipeout!<Enter> :else<Enter> :update<Enter> :bwipeout<Enter> :endif<Enter><Enter>
nnoremap <silent> <Leader>Z :wall <Bar> %bdelete <Bar> edit # <Bar> bdelete #<Enter>

nnoremap <silent> <Plug>AppendSemicolonRepeatable :call <SID>append_char('a')<Enter>
nmap <silent> <Leader>as <Plug>AppendSemicolonRepeatable

nnoremap <silent> <Plug>DeleteFinalRepeatable :call <SID>append_char('d')<Enter>
nmap <silent> <Leader>df <Plug>DeleteFinalRepeatable

nnoremap <silent> <Leader>ga :AsyncRun git add %:p<Enter> :edit!<Enter> :echo 'Added: ' . expand('%')<Enter>
nnoremap <silent> <Leader>gd :AsyncRun composer dump-autoload<Enter> :echo 'Dumped: ' . getcwd()<Enter>
nnoremap <silent> <Leader>gk :AsyncRun docker start db cache proxy apache74<Enter> :echo 'Docker starting...'<Enter>

nnoremap <silent> <Leader>gb :echo 'Branch: ' . <SID>get_branch()<Enter>
nnoremap <silent> <Leader>gp :echo 'Path: ' . getcwd()<Enter>

nnoremap <silent> <Leader>gf :echo 'Function: ' . <SID>get_function_name()<Enter>
nnoremap <silent> <Leader>gl :call <SID>go_line()<Enter>
nnoremap <silent> <Leader>gc :call <SID>get_current_function(1)<Enter>

function! s:find_filter(type)
    let l:saved_unnamed_register = @@
    let l:filter = ''

    if a:type ==# 'w'
        let l:filter = expand('<cword>')
    elseif a:type ==# 'v'
        normal! `<v`>y
        let l:filter = @@
    elseif a:type ==# 'char'
        normal! `[v`]y
        let l:filter = @@
    endif

    let @@ = l:saved_unnamed_register

    silent execute 'Rg ' . l:filter
endfunction

function! s:append_char(type) abort
    let l:saved_unnamed_register = @@
    execute "normal! ma$vy"
    let l:lastchar = @@

    if a:type == 'd'
        execute "normal! $x\e"
    elseif l:lastchar == ';'
        execute "normal! xA,\e"
    elseif l:lastchar == ','
        execute "normal! xA;\e"
    elseif l:lastchar == ' '
        execute "normal! g_lD\e"
    elseif (index(['"', "'", ')', ']'], l:lastchar) >= 0) || match(l:lastchar, "\a") || match(l:lastchar, "\d")
        execute "normal! A;\e"
    else
        echomsg 'Nothing to append to: ' . l:lastchar
    endif

    execute "normal! `a"
    let @@ = l:saved_unnamed_register

    silent! call repeat#set("\<Plug>" . (a:type == 'a' ? 'AppendSemicolon' : 'DeleteFinal') . 'Repeatable', a:type)
endfunction

function! s:go_line() abort
    try
        if match(getline('.'), ':') < 0
            throw 'Line dont has colon.'
        endif

        let l:parts = split(expand('<cWORD>'), ':')
        let l:file = strlen(l:parts[0]) > 0 ? l:parts[0] : ''
        let l:line = strlen(l:parts[1]) > 0 ? l:parts[1] : 0

        if filereadable(l:file) && l:line > 0
            execute 'edit +' . l:line . ' ' . l:file
        endif
    catch
        echohl WarningMsg
        echomsg 'Not is a valid line.'
        echohl None
    endtry

    return 0
endfunction

function! s:get_current_function(copy) abort
    if (index(['php'], &filetype) >= 0)
        let l:filename = expand('%:t:r')
        let l:functionname = <SID>get_function_name()
        let l:namespace = l:filename

        if len(l:functionname) > 0
            let l:namespace .= '::' . l:functionname
        endif

        if a:copy == 1
            let @+=l:namespace
            echomsg 'Copied: ' . l:namespace
        endif

        return l:namespace
    elseif a:copy == 1
        echohl WarningMsg
        echomsg 'Not is a php file.'
        echohl None
    endif

    return ''
endfunction

function! s:get_function_name() abort
    let l:parts = split(getline(search("^\\( \\{4}\\|\\t\\)\\?\\a\\S\\{-}\\( \\a\\S\\{-}\\)\\+\\s\\?(.*[^;]\\s\\{-}$", 'bWnc')), ' ')
    let l:counter = 1
    let l:result = ''

    for l:part in l:parts
        if l:part ==# 'function'
            let l:result = l:parts[l:counter]
            break
        endif

        let l:counter += 1
    endfor

    return substitute(l:result, '(.*', '', 'g')
endfunction

" Fast <Esc>
inoremap <silent> jk <Esc>
inoremap <silent> jj <Esc>

" Tabs navigation
noremap <silent> <Leader><Leader> :Buffers<Enter>
noremap <silent> <Tab> :call <SID>cycling_buffers(1)<Enter>
noremap <silent> <S-Tab> :call <SID>cycling_buffers(-1)<Enter>

function! s:cycling_buffers(incr) abort
    if a:incr == 1
                \ && bufexists(0)
                \ && expand('#') != ''
                \ && getbufvar(0, '&filetype') != 'help'
        execute "normal! \<C-^>"

        return
    endif

    let l:cbuffer = bufnr('%')
    let l:lbuffer = bufnr('$')
    let l:nbuffer = l:cbuffer + a:incr

    while 1
        if l:nbuffer != 0
                    \ && bufexists(l:nbuffer)
                    \ && bufname(l:nbuffer) != ''
                    \ && getbufvar(l:nbuffer, '&filetype') != 'help'
            execute ':buffer ' . l:nbuffer

            break
        else
            let l:nbuffer = nbuffer + a:incr

            if l:nbuffer < 1
                let l:nbuffer = l:lbuffer
            elseif l:nbuffer > l:lbuffer
                let l:nbuffer = 1
            endif

            if l:nbuffer == l:cbuffer
                echomsg 'Only buffer'

                break
            endif
        endif
    endwhile
endfunction

" Better split switching
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

if has('terminal')
    " Mappings to move out from terminal to other views
    tnoremap <C-h> <C-W>h
    tnoremap <C-j> <C-W>j
    tnoremap <C-k> <C-W>k
    tnoremap <C-l> <C-W>l
endif

if !has('gui_running')
    set notimeout
    set ttimeout
    set ttimeoutlen=10

    augroup FastEscape
        autocmd!

        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif

" Plugins
" @see https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/sonokai'
Plug 'jacoborus/tender.vim'

Plug 'tpope/vim-commentary'                                          " gcc
Plug 'tpope/vim-surround'                                            " cs"', viwS'
Plug 'tpope/vim-repeat'                                              " Repeat: surround and other more
" Plug 'tpope/vim-abolish'
Plug 'wellle/targets.vim'                                            " {operator}ia, {operator}aa
Plug 'michaeljsmith/vim-indent-object'                               " Indent deep as object: {operator}ii, {operator}ai
Plug 'justinmk/vim-sneak'                                            " f, F with super powers: s{2-chars}, S{2-chars}
Plug 'machakann/vim-swap'                                            " Swag args: g>, g<
Plug 'Raimondi/delimitMate'                                          " Append close: ', ", ), ], etc
" " Plug 'luochen1990/rainbow'
Plug 'mg979/vim-visual-multi'                                        " <C-n>, <C-s>

Plug 'neoclide/coc.nvim', {'branch': 'release'}                      " Autocomplete
Plug 'skywind3000/asyncrun.vim'                                      " Async tasks from vim: git add, docker start, etc
Plug 'airblade/vim-gitgutter'                                        " Show changes in git
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                  " Open and find files
Plug 'junegunn/fzf.vim'                                              " using a fuzzy finder
Plug 'SirVer/ultisnips'                                              " Performance using shortcuts
Plug 'sniphpets/sniphpets'                                           " PHP snippet with namespace resolve
Plug 'junegunn/goyo.vim'                                             " Zen mode

Plug 'StanAngeloff/php.vim', {'for': 'php'}                          " Better highlight syntax for PHP: unmanteined
Plug 'vim-syntastic/syntastic', {'for': 'php'}                       " Diagnostic code on-the-fly
Plug 'preservim/tagbar', {'for': ['php', 'c']}                       " Navigate: methods, vars, etc
Plug 'vim-php/tagbar-phpctags.vim', {'for': 'php'}                   " Tagbar for PHP in on-the-fly
Plug 'vim-test/vim-test', {'for': 'php'}                             " Run test: <Leader>{tt|tf|ts|tg}
" Plug 'vim-vdebug/vdebug', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'} " LSP and refactor tool

Plug 'vim-scripts/autotags', {'for': 'c'}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'c'}

" Plug 'AndrewRadev/tagalong.vim', {'for': ['html', 'xml', 'vue']}
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'vue']}              " Performance using emmet syntax
Plug 'ap/vim-css-color',  {'for': ['html', 'css', 'vue', 'vim']}     " Preview html colors

call plug#end()

" Use Syntastic to diagnostics
" PHPActor as LSP for PHP
" CLangd as LSP for C
" ~/.vim/coc-settings.json
"{
"  "diagnostic.enable": false,
"  "diagnostic.enableSign": false,
"  "diagnostic.signOffset": 9999999,
"  "phpactor.enable": true,
"  "phpactor.path": "~/.vim/plugged/phpactor/bin/phpactor",
"  "clangd.path": "/usr/local/clang_9.0.0/bin/clangd"
"}
" ~/.config/phpactor/phpactor.json
"{
"  "language_server_code_transform.import_globals": true,
"  "language_server_completion.trim_leading_dollar": true,
"  "file_path_resolver.enable_logging": true,
"  "completion_worse.disabled_completors": [],
"  "indexer.exclude_patterns": [
"    "\/tests\/coverage\/**\/*",
"    "\/vendor\/**\/Tests\/**\/*",
"    "\/vendor\/**\/tests\/**\/*",
"    "\/vendor\/composer\/**\/*"
"  ]
"}

" Themes
if has('termguicolors')
    set termguicolors
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
let g:gruvbox_bold = 0
let g:gruvbox_invert_selection = 0

let g:dracula_italic = 1
let g:dracula_bold = 0
let g:dracula_inverse = 0

let g:nord_italic = 1
let g:nord_italic_comments = 1

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1

" DelitMate
" @see https://github.com/Raimondi/delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

" Multiple Cursors
" @see https://github.com/mg979/vim-visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-n>'
let g:VM_maps["Select All"] = '<C-s>'

" Snippets (Default Maps: <Tab> <C-j> <C-k>)
" @see https://github.com/SirVer/ultisnips
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsUsePythonVersion = 3

" PHPVim
" @see https://github.com/StanAngeloff/php.vim
let g:php_version_id = 70400

" Emmet
" @see https://github.com/mattn/emmet-vim
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key = ','

" Vim Snake
" @see https://github.com/justinmk/vim-sneak
let g:sneak#label = 1

" Goyo
" @see https://github.com/junegunn/goyo.vim
let g:goyo_linenr = 1
let g:goyo_width = 120
let g:goyo_height = '100%'
let g:goyo_bg = '#1D2021'
nnoremap <silent> <F12> :Goyo<Enter>

" TagBar
" @see https://github.com/preservim/tagbar
nnoremap <silent> <F8> :TagbarToggle<Enter>

" Fzf
" @see https://github.com/junegunn/fzf.vim
" @see https://jdhao.github.io/2018/11/05/fzf_install_use/#installation
nnoremap <silent> <Leader>o :GFiles<Enter>
nnoremap <silent> <Leader>p :Files<Enter>
nnoremap <silent> <Leader>i :execute 'Files ' . expand('%:p:h')<Enter>

" Vim Tests
" https://github.com/vim-test/vim-test
let g:test#strategy = 'vimterminal'
let g:test#php#phpunit#options = {
    \ 'nearest': '--no-coverage --stop-on-failure',
    \ 'file':    '--no-coverage --stop-on-failure',
    \ 'suite':   '--no-coverage --stop-on-failure',
\}
nnoremap <silent> <Leader>tt :TestNearest<Enter>
nnoremap <silent> <Leader>tf :TestFile<Enter>
nnoremap <silent> <Leader>ts :TestSuite<Enter>
nnoremap <silent> <Leader>tl :TestLast<Enter>
nnoremap <silent> <Leader>tg :TestVisit<Enter>

" Syntastic
" @see https://github.com/vim-syntastic/syntastic
if exists('g:loaded_syntastic_plugin')
    set statusline+=%#WarningMsg#
    set statusline+=\ %{SyntasticStatuslineFlag()}
    set statusline+=%*
endif

let g:syntastic_stl_format = '%fe!'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_php_checkers = ['php']
let g:syntastic_auto_loc_list = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol = 'E'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_style_warning_symbol = 's'

" Vim Debug
" @see vim-vdebug/vdebug
let g:vdebug_keymap = {
\    'run' : '<F5>',
\    'step_into' : '<F7>',
\    'step_over' : '<F8>',
\    'step_out' : '<S-F8>',
\    'close' : '<S-F5>',
\    'detach' : '<F10>',
\    'set_breakpoint' : '<C-F8>',
\    'eval_visual' : '<Leader>xe'
\}

if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif

let g:vdebug_options = {
\    'port' : 9000,
\    'timeout' : 10,
\    'on_close' : 'detach',
\    'break_on_open' : 0,
\    'watch_window_style' : 'compact',
\    'simplified_status' : 1,
\    'continuous_mode' : 1,
\    'ide_key' : 'PHPSTORM'
\}

" COC Completion
" @see https://github.com/neoclide/coc.nvim
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-phpactor',
    \ 'coc-clangd'
    \]

" Use <Ctrl-Space> to trigger completion.
inoremap <silent> <expr> <C-@> coc#refresh()

" Make <Enter> auto-select the first completion item
inoremap <silent> <expr> <Enter> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<Enter>\<C-r>=coc#on_enter()\<Enter>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<Enter>

function! s:show_documentation() abort
    let l:word = expand('<cword>')

    if (index(['vim','help'], &filetype) >= 0)
        try
            execute 'help ' . l:word
        catch
            echohl WarningMsg
            echomsg 'Not found: ' . l:word
            echohl None
        endtry
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . ' ' . l:word
    endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups. (Used in long file definitions)
if has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" @see https://github.com/vim/vim/issues/4738
nnoremap gx :call <SID>go_url()<Enter>

function! s:go_url() abort
    let l:uri = expand('<cWORD>')
    let l:uri = substitute(l:uri, '?', '\\?', '')
    let l:uri = shellescape(l:uri, 1)

    if l:uri != ''
        silent execute "!/opt/firefox/firefox '" . l:uri . "'"

        silent redraw!
    endif
endfunction

" @see https://vim.fandom.com/wiki/Faster_loading_of_large_files
" file is large from 2mb
augroup LargeFile
    autocmd!

    autocmd VimEnter * nested call <SID>check_large_file()
    autocmd BufReadPre * call <SID>check_large_file()
augroup END

function! s:check_large_file() abort
    let l:maxsize = 1024 * 1024 * 2
    let l:fsize = getfsize(expand('<afile>'))

    if l:fsize > l:maxsize || l:fsize == -2
        " No syntax highlighting event
        set eventignore+=FileType
        setlocal noswapfile
        setlocal bufhidden=unload
        setlocal buftype=nowrite
        setlocal undolevels=-1

        echohl WarningMsg
        echomsg 'The file is larger than ' . (l:maxsize / 1024 / 1024) . ' MB, so some options are changed.'
        echohl None
    endif
endfunction

" CTags
" @see https://github.com/vim-scripts/autotags
nnoremap <C-]> g<C-]>
let g:autotags_no_global = 0
let g:autotags_cscope_file_extensions = '.php .h .c'
let g:autotags_ctags_global_include = ''
let g:autotags_ctags_opts = '--exclude="\.git" --exclude="\.idea" --exclude="\.vscode" --exclude=bin --exclude=var --exclude="*Test.php" --exclude="*phpunit*" --exclude=node_modules --exclude=storage --exclude=database --tag-relative=yes --c++-kinds=+p --regex-php="/^[ 	]*trait[ 	]+([a-z0_9_]+)/\1/t,traits/i" --php-kinds=+cfi-vj --fields=+aimlS --extra=+q'

" GitGutter
" @see https://github.com/airblade/vim-gitgutter
let g:gitgutter_sign_priority = 10000
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_close_preview_on_escape = 1

" Rainbow
" @see https://github.com/luochen1990/rainbow
let g:rainbow_active = 1

" Tagalong
" @see https://github.com/AndrewRadev/tagalong.vim
let g:tagalong_filetypes = ['html', 'xml']

nnoremap <Leader>lp :call <SID>create_list_parameters()<Enter>

function! s:create_list_parameters() abort
    let l:saved_unnamed_register = @@

    if match(getline('.'), '(') > 0 && match(getline('.'), ')') > 0 && match(getline('.'), ',') > 0
        execute 'normal! _f(vi(y'

        let l:command_string = ''
        let l:arguments_list = split(@@, ',')

        for l:argument in l:arguments_list
            let l:command_string .= "\t" . trim(l:argument) . (len(l:arguments_list) > 1 ? ',' : '') . "\r"
            call remove(l:arguments_list, 0)
        endfor

        execute "normal! \"_di(i\r" . l:command_string . "\e"

        echomsg 'Parameter list created'
    else
        echohl WarningMsg
        echomsg 'Not is a parameter list'
        echohl None
    endif

    let @@ = l:saved_unnamed_register
endfunction

nnoremap <Leader>la :call <SID>create_list_array()<Enter>

function! s:create_list_array() abort
    let l:saved_unnamed_register = @@

    if match(getline('.'), '[') > 0 && match(getline('.'), ']') > 0 && match(getline('.'), ',') > 0
        execute 'normal! _f[vi[y'

        let l:command_string = ''
        let l:arguments_list = split(@@, ',')

        for l:argument in l:arguments_list
            let l:command_string .= "\t" . trim(l:argument) . ",\r"
        endfor

        execute "normal! \"_di[i\r" . l:command_string . "\e"

        echomsg 'Array list created'
    else
        echohl WarningMsg
        echomsg 'Not is an array list'
        echohl None
    endif

    let @@ = l:saved_unnamed_register
endfunction

noremap <silent> <F2> :call <SID>quickfix_toggle(0)<Enter>

function! s:quickfix_toggle(forced)
    if exists('g:qfix_win') && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr('$')
    endif

    return 0
endfunction

augroup AutoCommands
    autocmd!

    " Reload after save
    autocmd BufWritePost ~/.vimrc source ~/.vimrc

    " Return to last edit position when opening files
    autocmd BufReadPost *
         \ if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line('$') |
         \   execute "normal! g`\"" |
         \ endif

    " Ominifunctions
    autocmd FileType c setlocal omnifunc=ccomplete#CompleteCpp
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    " autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    " PHP Customization
    autocmd FileType php setlocal commentstring=//\ %s
    autocmd FileType php inoremap <silent> <buffer><Leader>uu <Esc>:call phpactor#UseAdd()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>uu :call phpactor#UseAdd()<Enter>

    " PHP Refactor
    " @see https://github.com/phpactor/phpactor
    autocmd FileType php nnoremap <silent> <buffer><Leader>rnc :call phpactor#ClassNew()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>rxc :call phpactor#ClassExpand()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>ruu :call phpactor#ImportMissingClasses()<Enter>

    autocmd FileType php nnoremap <silent> <buffer><Leader>rmf :call phpactor#MoveFile()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>rcf :call phpactor#CopyFile()<Enter>

    autocmd FileType php nnoremap <silent> <buffer><Leader>ram :call <SID>phpactor('implement_contracts')<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>rap :call <SID>phpactor('add_missing_properties')<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>rfc :call <SID>phpactor('complete_constructor')<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>run :call <SID>phpactor('fix_namespace_class_name')<Enter>

    autocmd FileType php nnoremap <silent> <buffer><Leader>rei :call phpactor#ClassInflect()<Enter>
    autocmd FileType php xnoremap <silent> <buffer><Leader>rem :<C-u>call phpactor#ExtractMethod()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>rec :call phpactor#ExtractConstant()<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>ree :call phpactor#ExtractExpression(v:true)<Enter>
    autocmd FileType php nnoremap <silent> <buffer><Leader>R :call phpactor#ContextMenu()<Enter>

    autocmd FileType php nmap <silent> gd :call phpactor#GotoDefinition()<Enter>
"     autocmd FileType php nmap <silent> gy :call phpactor#GotoImplementations()<Enter>
"     autocmd FileType php nmap <silent> gr :call phpactor#FindReferences()<Enter>

    function! s:phpactor(transformer) abort
        silent update!

        let l:result = system(g:phpactorbinpath . ' class:transform ' . expand('%') . ' --transform="' . a:transformer . '"')

        silent edit!
    endfunction

    " PHPFixer
    autocmd FileType php nnoremap <silent> <buffer><F1> :call <SID>phpfixer()<Enter>

    function! s:phpfixer() abort
        if bufname('%') == ''
            echohl WarningMsg
            echomsg 'Save file first!.'
            echohl None

            return 0
        endif

        let l:configfile = !filereadable(expand('.php_cs')) ? '/var/www/html/freddiegar/services/.php_cs' : '.php_cs'

        silent update!

        let l:result = system('php-cs-fixer fix ' . expand('%') . ' --config="' . l:configfile . '"')

        silent edit!
    endfunction

    " Customization
    autocmd FileType sql setlocal commentstring=--\ %s
    autocmd FileType html,css,vue EmmetInstall
    autocmd FileType html,xml setlocal matchpairs+=<:>
    autocmd FileType php,c setlocal matchpairs-=<:>
    autocmd FileType json setlocal softtabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile .env.* setlocal filetype=sh
    autocmd BufRead,BufNewFile *.tphp setlocal filetype=php
    autocmd BufRead,BufNewFile *.twig setlocal filetype=html
    autocmd BufRead,BufNewFile *.blade.php setlocal filetype=html

    " Rg not find in file names
    command! -nargs=* -bang Rg call <SID>rgfzf(<q-args>, <bang>0)

    function! s:rgfzf(query, fullscreen) abort
        let l:command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
        let l:initial_command = printf(l:command_fmt, shellescape(a:query))
        let l:reload_command = printf(l:command_fmt, '{q}')
        let l:spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:' . l:reload_command]}

        call fzf#vim#grep(l:initial_command, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
    endfunction

    " Save|Load sessions
    let g:session_file =  expand('~/.vim/sessions/' . split(getcwd(), '/')[-1] . '.vim')

    function! s:sessionload() abort
        if !argc() && isdirectory('.git') && empty(v:this_session) && filereadable(g:session_file) && !&modified
            execute 'source ' . g:session_file
            execute 'highlight! link SignColumn LineNr'
            execute 'highlight! link StatusLine LineNr'

            echomsg 'Loaded ' . g:session_file . ' session'
        else
            echomsg 'None ' . g:session_file . ' session'
        endif
    endfunction

    function! s:sessionsave() abort
        if isdirectory('.git')
            execute 'mksession! ' . g:session_file

            echomsg 'Saved ' . g:session_file . ' session'
        endif
    endfunction

    autocmd VimEnter * nested call <SID>sessionload()
    autocmd InsertEnter * :setlocal norelativenumber
    autocmd InsertLeave * :setlocal relativenumber
    autocmd VimLeavePre * call <SID>sessionsave()
    " autocmd VimResized * wincmd =
augroup END

augroup ThemeColors
    autocmd!

    set background=dark

    try
        let g:weekDay = str2nr(strftime('%w'))
        let g:colorschemes = ['tender', 'dracula', 'nord', 'sonokai']
        let g:colorscheme = get(g:colorschemes, g:weekDay, 'gruvbox')

        execute 'colorscheme ' . g:colorscheme
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme evening

        echohl WarningMsg
        echomsg 'Not found colorscheme: ' . g:colorscheme
        echohl None
    endtry

    function! s:themes() abort
        " Transparency
        " Use #1D2021 in Terminal
        highlight! Normal guibg=NONE ctermbg=NONE

        " SignColumn with same color of theme
        highlight! link SignColumn LineNr
        highlight! SpecialKey ctermfg=239 guifg=#504945

        " GitGutter with same color of theme
        highlight! GitGutterAdd guifg=#009900 ctermfg=2
        highlight! GitGutterChange guifg=#bbbb00 ctermfg=3
        highlight! GitGutterDelete guifg=#ff2222 ctermfg=1
        highlight! link GitGutterAddLineNr Underlined
        highlight! link GitGutterChangeLineNr Underlined
        highlight! link GitGutterDeleteLineNr Underlined
        highlight! link GitGutterChangeDeleteLineNr Underlined

        " Syntastic with same color of theme
        highlight! SyntasticErrorSign guifg=#ff2222 ctermfg=1
        highlight! SyntasticWarningSign guifg=#bbbb00 ctermfg=3

        " Goyo
        autocmd! User GoyoLeave nested
            \ highlight! link SignColumn LineNr |
            \ highlight! SpecialKey ctermfg=239 guifg=#504945 |
            \ highlight! Normal guibg=NONE ctermbg=NONE
    endfunction

    call <SID>themes()

    autocmd ColorScheme * call <SID>themes()
augroup END

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

execute 'augroup END'
let mapleader = ","

call pathogen#infect()

"Basic config.
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
set number
set autoindent
set tabstop=4
set softtabstop=4
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove menu bar
set mouse=a

"Key mappings
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Enable fancy mode 
let g:Powerline_symbols = 'fancy'   " Powerline

nnoremap <F5> :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>

"shortcuts to run coffeescript
au BufNewFile,BufReadPost *.coffee nnoremap <F4> :CoffeeRun<CR>
au BufNewFile,BufReadPost *.coffee nnoremap <F3> :CoffeeCompile watch vert<CR>

"LESS
autocmd BufWritePost,FileWritePost *.less :silent !lessc <afile> <afile>:r.css

"coffeescript 2 space indent
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.py setl shiftwidth=4 expandtab
"Coffeescript recompile on write
au BufWritePost *.coffee silent CoffeeMake!

" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0
" Python (tab width 4 chr, wrap at 79th char)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python set textwidth=79

" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
autocmd FileType css set textwidth=79
" JavaScript (tab width 4 chr, wrap at 79th)
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=4
autocmd FileType javascript set sts=2
autocmd FileType javascript set textwidth=79

" Haskell 
"autocmd FileType haskell set expandtab smarttab sw=4

autocmd FileType haskell set sw=4
autocmd FileType haskell set expandtab smarttab
autocmd FileType haskell set nojoinspaces
autocmd FileType haskell set textwidth=79


" Clojure {{{

let g:slimv_leader = '\'
let g:slimv_keybindings = 2
let g:paredit_mode = 0
let vimclojure#WantNailgun = 0
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

augroup ft_clojure
    au!

	au BufNewFile,BufRead *.clj set filetype=clojure

    au FileType clojure silent! call TurnOnClojureFolding()
    "au FileType clojure compiler clojure
    au FileType clojure setlocal report=100000

    au FileType clojure set sw=2
    au FileType clojure set ts=2

    au BufWinEnter            SLIMV.REPL setlocal nolist
    au BufNewFile,BufReadPost SLIMV.REPL setlocal nowrap foldlevel=99
    au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> A GA
    au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> <localleader>R :emenu REPL.<Tab>

    " Fix the eval mappings.
    au FileType clojure nnoremap <buffer> <localleader>ef :<c-u>call SlimvEvalExp()<cr>
    au FileType clojure nnoremap <buffer> <localleader>ee :<c-u>call SlimvEvalDefun()<cr>

    " And the inspect mapping.
    au FileType clojure nmap <buffer> \i \di

    " Indent top-level form.
    au FileType clojure nmap <buffer> <localleader>= v((((((((((((=%
augroup END

" }}}

" SLIMV {{{

let g:slimv_repl_name = 'SLIMV.REPL'
let g:slimv_repl_split = 4
let g:slimv_repl_syntax = 1
let g:slimv_repl_wrap = 0

" Use a swank command that works, and doesn't require new app windows.
let g:slimv_swank_clojure = '!dtach -n /tmp/dtach-swank.sock -r winch lein swank'


" }}}}


" Code folding {{{

set foldlevelstart=0
set foldmethod=marker
set foldnestmax=10
set foldenable

" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" Color Scheme{{{
syntax enable
set background=dark
colorscheme molokai
" }}}

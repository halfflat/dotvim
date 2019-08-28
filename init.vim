set encoding=utf-8
set shiftwidth=4
set laststatus=2
set backspace=2
set hlsearch
set nojoinspaces
set wildmenu
set statusline=%<%f\ %{fugitive#statusline()}%h%m%r%=%-14.(%l,%c%V%)\ %P

" maintain separate cache directory for neovim
if has('nvim')
    let s:datadir=$HOME."/.local/share/nvim"
    let &viminfo="'100,s100,<10000"
    set undofile
else
    let s:datadir=$HOME."/.local/share/vim"
    let &viminfo="'100,s100,<10000,n".s:datadir."/viminfo"
    let &directory=s:datadir."/swap"
    let &backupdir=s:datadir."/backup"
    if v:version > 702
        let &undodir=s:datadir."/undo"
        set undofile
    endif
endif

set hidden

filetype plugin on

" pathogen script manages .vim/bundle scripts
let g:pathogen_blacklist=[]
if v:version < 703 && !has("gui")
    let g:pathogen_blacklist=["csapprox"]
endif
set rtp+=~/.vim/bundle/pathogen
call pathogen#infect()

" buftabline plugin options
let g:buftabline_indicators=1
let g:buftabline_separators=1

" vim markdown plugin options
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

" diffchar plugin options
let g:DiffModeSync=0

" vim-signature customization
let g:SignatureMarkOrder="\m▶"
let g:SignatureWrapJumps=0

" riv plugin options
let g:riv_disable_folding=1

" latex-unicorder plugin options
" (use own keybindings)
" let g:unicoder_cancel_normal=1
" let g:unicoder_cancel_insert=1
" let g:unicoder_cancel_visual=1
let g:unicoder_no_map=1

" rainbow parentheses plugin
let g:rainbow_active=1

aug cgroup
au!
au FileType * set nocindent noautoindent
au FileType c,h,cc,cpp,cs,hpp,cu,java set cindent
au FileType c,h,cc,cpp,cmake,cs,hpp,cu,haskell,java,json,julia,python,scheme,racket,lisp,sh,yaml set expandtab softtabstop=4
aug END

set cinoptions=>s,:0,l1,g0,t0,Ws
    set cinkeys=0{,0},:,0#,!<Tab>,!^F

" special character display
set list
set listchars=tab:⇥\ ,trail:␣,nbsp:⍽
set showbreak=↳
set cpoptions+=n

" spell check
set spelllang=en

" local keybindings

" fast switch buffer
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprev<cr>

" step between number mode, relative number mode, and no number
noremap <silent> <Leader>n :if &number<bar>set nonumber<bar>set rnu<bar>elseif &rnu<bar>set nornu<bar>set showbreak=↪<bar>else<bar>set number<bar>set showbreak=\ \ ↪\ <bar>endif<cr>

" toggle mark display (vim-signature plugin)
noremap <Leader>m :SignatureToggle<cr>

" delete buffer but keep window (use bbye plugin instead
" of bp|bd#).
noremap <Leader>q :Bdelete<cr>

" invoke EasyAlign plugin with Tab
xmap <Tab>  <Plug>(EasyAlign)
nmap g<Tab> <Plug>(EasyAlign)

" invoke latex-unicode conversion
nnoremap <Leader>l :call unicoder#start(0)<cr>
vnoremap <Leader>l :<c-u>call unicoder#selection()<cr>

" toggle rainbow parentheses
noremap <Leader>r :RainbowToggle<cr>

" redraw and clear search highlight, update diff, highlight current line
function! SetNoCul(x)
    set nocul
endf
function Refresh()
    redraw
    if has('diff')
        diffupdate
    endif
    if has('timers')
        set cul
        call timer_start(200, 'SetNoCul')
    endif
endf
nnoremap <silent> <c-l> :noh<bar>call Refresh()<cr>
inoremap <silent> <c-l> <c-o>:noh<bar>call Refresh()<cr>

" quick copy to/paste from clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>d "+d
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
set clipboard=unnamed

" prev and next match from quickfix and location lists
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>

" arrow short cuts for prev/next mark
nnoremap <c-Down> ]`
vnoremap <c-Down> ]`
nnoremap <c-Up> [`
vnoremap <c-Up> [`

" redo all undos
nnoremap <Leader>r :exec 'undo' undotree()['seq_last']<cr>
vnoremap <Leader>r :exec 'undo' undotree()['seq_last']<cr>

" highlighting
colorscheme charon
syntax on
highlight SignColumn NONE
highlight CursorLine guibg=green ctermbg=yellow guifg=black ctermbg=black term=reverse
highlight SignatureMarkText guifg=green ctermfg=green guibg=black ctermbg=black
highlight VertSplit guifg=darkgrey ctermfg=darkgrey
highlight Whitespace guifg=green ctermfg=green gui=underline term=underline

" subdued vertical split
set fillchars+=vert:·

" fixed font in gui; menus & scrollbars:
set guifont=Fixed\ Medium\ Semi-Condensed\ 10
" set guifont=6x13

set guioptions=aegi
" set guioptions=aegimt


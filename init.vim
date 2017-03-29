set encoding=utf-8
set shiftwidth=4
set laststatus=2
set backspace=2
set hlsearch
set nojoinspaces
set wildmenu
set statusline=%<%f\ %{fugitive#statusline()}%h%m%r%=%-14.(%l,%c%V%)\ %P

" maintains eparate cache directory for neovim
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
highlight SignatureMarkText guifg=green ctermfg=green guibg=black ctermbg=black
let g:SignatureMarkOrder="\m▶"
let g:SignatureWrapJumps=0

aug cgroup
au!
au FileType * set nocindent noautoindent
au FileType c,h,cc,cpp,cs,hpp,java set cindent
au FileType c,h,cc,cpp,cmake,cs,hpp,java,julia,python set expandtab softtabstop=4
aug END

set cinoptions=>s,:0,l1,g0,t0,Ws
set cinkeys=0{,0},:,0#,!<Tab>,!^F

" local keybindings

" fast switch buffer
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprev<cr>

" step between number mode, relative number mode, and no number
noremap <silent> <Leader>n :if &number<bar>set nonumber<bar>set rnu<bar>elseif &rnu<bar>set nornu<bar>else<bar>set number<bar>endif<cr>

" toggle mark display (vim-signature plugin)
noremap <Leader>m :SignatureToggle<cr>

" delete buffer but keep window
noremap <Leader>d :bp<bar>bd #<cr>

" invoke EasyAlign plugin with Tab
xmap <Tab>  <Plug>(EasyAlign)
nmap g<Tab> <Plug>(EasyAlign)

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
noremap <silent> <c-l> :noh<bar>call Refresh()<cr>
inoremap <silent> <c-l> <c-o>:noh<bar>call Refresh()<cr>

" quick copy to/paste from clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" prev and next match from 
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>

" highlighting
colorscheme charon
syntax on
highlight SignColumn NONE
highlight! link EOLWhiteSpace Error
highlight CursorLine guibg=green ctermbg=yellow guifg=black ctermbg=black term=reverse 
aug hgroup
au!
au Syntax * syntax match EOLWhiteSpace "\s\+$"
aug END

" fixed font in gui; menus & scrollbars:
set guifont=Fixed\ Medium\ Semi-Condensed\ 10
" set guifont=6x13
set guioptions=aegi
" set guioptions=aegimt


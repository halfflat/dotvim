set encoding=utf-8
set shiftwidth=4
set laststatus=2

set wildmenu

" maintains eparate cache directory for neovim
if has('nvim')
    let s:datadir = $HOME."/.local/share/nvim"
    let &viminfo="'100,s100,<10000"
else
    let s:datadir = $HOME."/.local/share/vim"
    let &viminfo="'100,s100,<10000,n".s:datadir."/viminfo"
    let &undodir=s:datadir."/undo"
    let &directory=s:datadir."/swap"
    let &backupdir=s:datadir."/backup"
endif

set undofile
set hidden

filetype plugin on

" pathogen script manages .vim/bundle scripts
set rtp+=~/.vim/bundle/pathogen
call pathogen#infect()

" buftabline plugin options
let g:buftabline_indicators=1
let g:buftabline_separators=1

" vim markdown plugin options
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

aug cgroup
au!
au FileType * set nocindent noautoindent
au FileType c,h,cc,cpp,hpp,java,cs set cindent
au FileType c,h,cc,cpp,hpp,java,cs,python set expandtab softtabstop=4
aug END

set cinoptions=>s,:0,l1,g0,t0,Ws
set cinkeys=0{,0},:,0#,!<Tab>,!^F

" local keybindings

" fast switch buffer
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprev<cr>

" step between number mode, relative number mode, and no number
noremap <Leader>n :if &rnu<bar>set nornu<bar>set number<bar>elseif &number<bar>set nonumber<bar>else<bar>set rnu<bar>endif<bar><cr>

" toggle mark display (vim-signature plugin)
noremap <Leader>m :SignatureToggle<cr>

" delete buffer but keep window
noremap <Leader>d :bp<bar>bd #<cr>

" invoke EasyAlign plugin with Tab
xmap <Tab>  <Plug>(EasyAlign)
nmap g<Tab> <Plug>(EasyAlign)

" redraw and clear search highlight
nmap <c-l> :redraw<bar>:noh<cr>

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
aug hgroup
au!
au Syntax * syntax match EOLWhiteSpace "\s\+$"
aug END

" vim-signature customization
highlight SignatureMarkText guifg=green ctermfg=green guibg=black ctermbg=black
let g:SignatureMarkOrder="\m▶"
let g:SignatureWrapJumps=0

" fixed font in gui; menus & scrollbars:

set guifont=Fixed\ Medium\ Semi-Condensed\ 10
" set guifont=6x13
" set guioptions=aegimt
set guioptions=aegi


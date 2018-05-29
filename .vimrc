set undodir=$HOME/.vim/undodir/
set undofile
set rtp+=~/.fzf/bin/fzf
set completeopt-=preview
set number
set numberwidth=2
set hidden
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

colorscheme darkblack

function OpenInNewWindow(file)
	call system("byobu new-window -n ".a:file." 'vim ".a:file."'")
endfunction

function Print(thing)
	return a:thing
endfunction

function CompleteFileFind(...)
	let f = fzf#run({'sink':function('Print'),'dir':'.','options':'-q "'.a:1.'"'})
	return string(get(f, 0, a:1))
endfunction

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window -t \"$(tmux display-message -pt \"$TMUX_PANE\" '#{window_index}')\" " . expand("%:t"))

let mapleader = "\<Space>"
map <silent> <leader>fo :Files .<cr>
map <silent> <leader>fn :call feedkeys(":Open \<tab>", 'tn')<cr>
map <silent> <leader>fs :w<cr>
map <silent> <leader>qq :q<cr>
map <silent> <leader>qs :x<cr>
noremap <leader>y "+y
noremap <leader>pp "+p
map <silent> <leader>rs :call lsc#server#restart()<cr>

command -nargs=1 -complete=custom,CompleteFileFind Open :call OpenInNewWindow(<args>)
command -nargs=0 Back :e #

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'natebosch/vim-lsc'
call plug#end()
let g:lsc_auto_map = v:true " Use defaults
let g:lsc_trace_level = 'off'
let g:lsc_server_commands = {
    \ 'rust': 'rls',
    \ 'scala':'node '.expand('~/bin/sbt-server-stdio.js'),
    \ 'sbt':'node '.expand('~/bin/sbt-server-stdio.js'),
    \ 'sh':'bash-language-server start'
    \}

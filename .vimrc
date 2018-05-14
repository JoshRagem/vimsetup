set rtp+=~/.fzf/bin/fzf
set completeopt-=preview
set number
set numberwidth=2
colorscheme darkblack

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window -t \"$(tmux display-message -pt \"$TMUX_PANE\" '#{window_index}')\" " . expand("%:t"))

let mapleader = "\<Space>"
map <silent> <leader>of :Files .<cr>

command -nargs=1 -complete=file Open :call system("byobu new-window -n "<args>" 'vim <args>'")
command -nargs=0 Back :e #

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
call plug#end()

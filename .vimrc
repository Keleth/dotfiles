" plugins i think move it to external file for plugins
" so ~/.vim/plugins.vim
" from here ------ 
" plug.vim
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" calendar
Plug 'itchyny/calendar.vim'
" wiki
Plug 'catppuccin/vim'
"" Plug 'yorickpeterse/vim-paper'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" wiki
Plug 'vimwiki/vimwiki'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/taglist.vim'
" PHP
" Plug 'StanAngeloff/php.vim', {'for': 'php'} 
" python
Plug 'klen/python-mode', {'for': 'python'}
"ctrlp (<C-p>) поиск по названиям файлов в директории
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
" Plug 'wfxr/minimap.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Initialize plugin system
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
"
" ------- to here
"------------------------------------------------------------------
set nocompatible

set keymap=russian-jcukenwin
set iminsert=0 " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0 " Чтобы при старте поиск был на английском, а не русском (start > /)
" Дополнительно можно добавить:
" Чтобы вместо Ctrl-^ нажимать Ctrl-\
inoremap <C-\> <C-^>
set number           " номера строк
set autowriteall     " автосохранение при переключении буферов
set complete=.,w,b,u


" меняю табы на пробелы
set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" начинаем скролить с 8 строк до края
set scrolloff=8 

set relativenumber

let g:netrw_altfile=1
let g:netrw_preview=1

"set gfn=Ubuntu 12
" подсветка поиска
syntax on
if has('gui_running')
    set guioptions -=T
    set guifont=FiraCode\ Nerd\ Font\ Mono\ \14
endif

" colors
set termguicolors
set background=dark
colorscheme catppuccin_macchiato

" Смена цвета курсора для русской расклдаки
highlight lCursor guifg=NONE guibg=Cyan

if !has('gui_running')
    highlight Normal guibg=NONE
    highlight NonText guibg=NONE
    highlight Normal ctermbg=NONE
    highlight NonText ctermbg=NONE
endif

" Замена фона у номеров строк
hi LineNr guibg=bg
" hi LineNr guibg=grey
" отступ
" set foldcolumn=2
" hi foldcolumn guibg=bg

" let g:airline_theme='default'
set hlsearch
set incsearch

" disable scrollbars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

filetype plugin on

let mapleader=" "

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "ksnippets"]

" edit config
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
" reload config
" nnoremap <leader><CR> :so ~/.vimrc<CR>
" fzf for current directory with :Files, and git project with :GFiles
nnoremap <leader>pf :Files<CR>
nnoremap <C-p> :GFiles<CR>
" File browser in vertical split
nnoremap <leader>pv :Vex<CR>
nnoremap <SPACE> <Nop>
" for navigating through quickfix results, for example (:grep SOCKET **/*.c)
nnoremap <C-j> :cprev<CR>
nnoremap <C-k> :cnext<CR>
" move selected line with J, K up and down considering idents
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" map Y for visual and normal modes to copying into system clipboard
nnoremap Y "+y         
vnoremap Y "+y
" turn-off highlight for searches results
nnoremap <leader><space> :nohlsearch<CR>


" Vim Wiki
" let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'sass', 'xml', 'html', 'java', 'sql', 'python', 'bash']

" Wiki
let g:vimwiki_list = [{'path': '~/ncloud/wiki', 'path_html': '~/ncloud/wiki/vim_html', 'auto_diary_index':1, 'syntax': 'markdown', 'ext': 'md'}]
au FileType vimwiki setlocal shiftwidth=4 tabstop=4 noexpandtab
let g:vimwiki_diary_months = {1: 'Январь', 2: 'Февраль', 3: 'Март', 4: 'Апрель', 5: 'Май', 6: 'Июнь',
        \7: 'Июль', 8: 'Август', 9: 'Сентябрь', 10: 'Октябрь',  11: 'Ноябрь', 12: 'Декабрь'
        \}
au BufNewFile,BufReadPost *.md set filetype=vimwiki
let g:vimwiki_global_ext = 0

" FZF
" function! FZF() abort
"     let l:tempname = tempname()
"     " fzf | awk '{ print $1":1:0" }' > file
"     execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
"     try
"         execute 'cfile ' . l:tempname
"         redraw!
"     finally
"         call delete(l:tempname)
"     endtry
" endfunction
" 
" " :Files
" command! -nargs=* Files call FZF()
" 
" " \ff
" nnoremap <leader>ff :Files<cr>
" End FZF

" minimap
" let g:minimap_width = 10
" let g:minimap_auto_start = 1
" let g:minimap_auto_start_win_enter = 1

" Keys
"map <F10> :NERDTreeToggle<CR>
"map <F10> :Vex<CR>
map <F4> :TlistToggle<CR>

" Autocomands
" source config after save
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

au filetype vimwiki silent! iunmap <buffer> <Tab>

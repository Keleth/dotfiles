" plug.vim
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" calendar
Plug 'itchyny/calendar.vim'
" wiki
Plug 'vimwiki/vimwiki'
" цветовая схема gruvbox
Plug 'morhetz/gruvbox'
" Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Initialize plugin system
call plug#end()
"
"------------------------------------------------------------------

" номера строк
set number

" меняю табы на пробелы
set expandtab
set tabstop=4
"set gfn=Ubuntu 12
" подсветка поиска
syntax on
colorscheme gruvbox
let g:airline_theme='gruvbox'
set background=dark
set hlsearch
set incsearch

set nocompatible
filetype plugin on

" Vim Wiki
let g:vimwiki_list = [{'path': '~/Yandex.Disk/wikiObsidian/wiki', 'path_html':'~/Yandex.Disk/wikiObsidian/wiki/export/html/', 'auto_diary_index':1}]
au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
let g:vimwiki_diary_months = {1: 'Январь', 2: 'Февраль', 3: 'Март', 4: 'Апрель', 5: 'Май', 6: 'Июнь',
			\7: 'Июль', 8: 'Август', 9: 'Сентябрь', 10: 'Октябрь',  11: 'Ноябрь', 12: 'Декабрь'
			\}
nnoremap <SPACE> <Nop>
let mapleader=" "
au BufNewFile,BufReadPost *.wiki set filetype=vimwiki
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'sass', 'xml', 'html', 'java', 'sql', 'python', 'bash']

" Keys
map <F10> :NERDTreeToggle<CR>
map <F4> :TlistToggle<CR>



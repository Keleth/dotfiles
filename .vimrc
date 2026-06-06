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
Plug 'morhetz/gruvbox'
"Plug 'dracula/vim', { 'as': 'dracula'}
"Plug 'altercation/vim-colors-solarized'
"" Plug 'yorickpeterse/vim-paper'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" wiki
Plug 'vimwiki/vimwiki'
"Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'vim-scripts/taglist.vim'
" PHP
" Plug 'StanAngeloff/php.vim', {'for': 'php'} 
" python
Plug 'klen/python-mode', {'for': 'python'}
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
" Plug 'wfxr/minimap.vim'
"Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Initialize plugin system
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'liuchengxu/vim-which-key'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'SirVer/ultisnips'
" Code completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Java-completion
Plug 'artur-shaik/vim-javacomplete2'
Plug 'majutsushi/tagbar'
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
    set guioptions -=m  " отключить главное меню
    set guioptions -=T
    set guifont=FiraCode\ Nerd\ Font\ Mono\ \12
endif

" colors
set termguicolors
set background=light
colorscheme gruvbox

" Tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


" Смена цвета курсора для русской расклдаки
highlight lCursor guifg=NONE guibg=Cyan

" if !has('gui_running')
"     highlight Normal guibg=NONE
"     highlight NonText guibg=NONE
"     highlight Normal ctermbg=NONE
"     highlight NonText ctermbg=NONE
" endif

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

" установка системного буфера обмена, если не указан регситр
set clipboard^=unnamedplus

" отключение бибика
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


filetype plugin on

" deoplete config
" Don't forget to start deoplete let g:deoplete#enable_at_startup = 1 " Less spam let g:deoplete#auto_complete_start_length = 2 
" Use smartcase
let g:deoplete#enable_smart_case = 1


" Setup completion sources
let g:deoplete#sources = {}

" IMPORTANT: PLEASE INSTALL JAVACOMPLETE2  AND ULTISNIPS OR DONT ADD THIS LINE!
" =====================================

let g:deoplete#sources.java = ['jc', 'javacomplete2', 'file', 'buffer', 'ultisnips']

" =====================================

""use TAB as the mapping
inoremap <silent><expr> <TAB>
    \ pumvisible() ?  "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "" {{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction "" }}}
" end deoplete config

" ultisnips config
" Since we are already using Deoplete, and using tab with both doesn't work nice use <c-j> instead
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" end ultisnips


let mapleader=" "
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" UltiSnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" let g:UltiSnipsSnippetDirectories=["UltiSnips", "ksnippets"]


" Airline
" ---- Airline Tabs setup ----
" Enable tabline to show all open buffers like tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Optional: show just filename
let g:airline#extensions#tabline#formatter = 'unique_tail'

" edit config
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>eb :tabedit ~/.bashrc<CR>
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
nnoremap <leader>p :call KlthSwitchTheme()<CR> 
nnoremap <S-l> :bn<CR>
nnoremap <S-h> :bp<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>Q :!bd<CR>
nnoremap <leader>w :w<CR>


" Vim Wiki
" let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'sass', 'xml', 'html', 'java', 'sql', 'python', 'bash']

" Wiki
let g:vimwiki_list = [{'path': '~/Nextcloud/vault', 'path_html': '~/Nextcloud/vault/export_html',
        \'auto_diary_index':1, 'syntax':'markdown', 'ext': 'md'}]
au FileType vimwiki setlocal shiftwidth=4 tabstop=4 noexpandtab
let g:vimwiki_diary_months = {1: 'Январь', 2: 'Февраль', 3: 'Март', 4: 'Апрель', 5: 'Май', 6: 'Июнь',
        \7: 'Июль', 8: 'Август', 9: 'Сентябрь', 10: 'Октябрь',  11: 'Ноябрь', 12: 'Декабрь'
        \}
" au BufNewFile,BufReadPost *.md set filetype=vimwiki
let g:vimwiki_global_ext = 0
au filetype vimwiki silent! iunmap <buffer> <Tab>

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
function! KlthSwitchTheme()
    let l:d = &background
    if d == "dark"
        set background=light
    else
        set background=dark
    endif
"    echo d

"    let l:c = g:colors_name
"    if c == "monokai"
"        colorscheme catppuccin_latte 
"    else
"        colorscheme monokai
"        AirlineTheme dark
"    endif
"    echo c
endfunction

function! KlthTriggerLocWindow()
    let l:c = getloclist(0, {'winid': 0}).winid 
    if c == 0
        lopen
    else
        lclose
    endif
endfunction


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
map <F2> :call KlthTriggerLocWindow()<CR> 
"map <F10> :NERDTreeToggle<CR>
"map <F10> :Vex<CR>
map <F4> :TagbarToggle<CR>
map <F5> :setlocal spell! spelllang=en_us,ru_ru<CR>
" fix spellcheck url
let g:spellfile_URL = 'https://ftp.nluug.nl/pub/vim/runtime/spell'


" Auto commands
" source config after save
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" au filetype vimwiki silent! iunmap <buffer> <Tab>

" Java completion
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java JCEnable

" Относительные номера строк только для режима редактирования
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

autocmd FileType html,javascript
  \ :iabbrev <buffer> cl console.log("");<esc>2hi
  \ :ab axios_ axiosExec({url: FRS().appPath + '/api/v2/', method: ''})<CR>.then(response => {<CR>console.log(response.data);<CR>})<CR>.catch(error => {<CR>axiosErrorHandler(error);<CR>});<ESC>06kf)hi
  \ :ab dce document.createElement('');<ESC>3hi
  \ :ab dct document.createTextNode('');<ESC>3hi


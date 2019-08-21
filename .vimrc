set nocompatible

call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lumiliet/vim-twig'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'KabbAmine/vCoolor.vim'
Plug 'fatih/vim-go'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-latex/vim-latex'
Plug 'dfm/shifttab.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'jalvesaq/Nvim-R'
Plug 'srcery-colors/srcery-vim'
Plug 'kmszk/skyknight'
Plug 'majutsushi/tagbar'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'

Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'donRaphaco/neotex', { 'for': 'tex' }

call plug#end()

filetype plugin indent on

" GLOBAL SETTINGS
let mapleader=","
set number relativenumber
set splitright
set splitbelow

" UI changes
set mouse=a
set backspace=indent,eol,start

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" AUTOCOMPLETE MENU
set wildmenu
set path+=**

" Code folding set to off
set nofoldenable

" Theme stuff
let g:quantum_black=1
let g:quantum_italics=1
let g:airline#extensions#tabline#enabled=1
set cursorline
set background=dark
set termguicolors
set t_Co=256
colorscheme srcery

let g:slime_target = "tmux"

" Airline fix
nnoremap <Leader>ar :AirlineRefresh<CR>

" YCM C++ Settings
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_log_level='debug'
let g:ycm_server_keep_logfiles = 1
let g:ycm_path_to_python_interpreter='/anaconda3/bin/python'

" Add tag searching to root dir
set tags=tags,./.git/tags

" Default file encoding to utf-8
set encoding=utf-8

" Linter configuration
let g:ale_linters = {
			\'html': ['htmlhint'],
			\'javascript': ['eslint', 'flow'],
            \'r': ['lintr']
			\}

" Allow Flow syntax
let g:javascript_plugin_flow=1

" Maps NerdTree to Alt-N -- OSX ONLY
noremap ˜ :NERDTreeToggle<CR>

" Tagbar support
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

nnoremap <Leader>tb :TagbarToggle<CR>

" Finds the next placeholder and enters insert mode
nnoremap <Leader><Space><Space> <CR>/<++><CR>:noh<CR>da>i

setlocal ts=4 sw=4 sts=0 expandtab

"autocmd FileType javascript setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType scss setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType json setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType go setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType julia setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType tex setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType yaml setlocal ts=2 sw=2 sts=0 expandtab

augroup FortranSettings
	autocmd!
	let fortran_free_source=1
	let fortran_have_tabs=1
	let fortran_more_precise=1
	let fortran_do_enddo=1
augroup END

augroup PythonSettings
	autocmd FileType python inoremap <S-tab> <C-o>:call ShiftTab()<CR>
	autocmd FileType python setlocal noshowmode
	autocmd FileType python noremap <Leader>;f <Esc>o<BS>def<Space><++>(<++>):<CR><++><Esc>
augroup END

augroup JuliaSettings
	autocmd FileType julia noremap <Leader>;f <Esc>o<BS>function<Space><++>(<++>)<Enter><++><Enter>end<Esc>
augroup END

augroup TexSettings
	autocmd!
	autocmd FileType tex setlocal ts=4 sw=4 sts=0 expandtab
	autocmd FileType tex set nofoldenable

	let g:Tex_AdvancedMath = 1
	let g:Tex_BibtexFlavor = 'biber'
	let g:Tex_GotoError = 0
	map <Leader>lb :<C-U>exec '!bibtex '.Tex_GetMainFileName(':p:t:r')<CR>
	map <F17> <S-F5>
	set spell
augroup END

augroup XMLSettings
	autocmd!
	autocmd FileType xml setlocal ts=4 sw=4 sts=0 expandtab
augroup END

augroup RSettings
	autocmd!
	autocmd FileType R setlocal ts=4 sw=4 sts=0 expandtab
	"let vimrplugin_assign 
	let R_assign = 0

	autocmd FileType r nnoremap Â A<Space>%>%<Space>
	autocmd FileType r inoremap Â <Space>%>%<Space>

	set foldmethod=indent

	let g:syntastic_enable_r_lintr_checker = 1
	let g:syntastic_r_checkers = ['lintr']

	let R_setwidth = 0
augroup END

autocmd BufRead,BufNewFile *.htmlhintrc setfiletype json

" Git diffs
let g:gitgutter_realtime=0
let g:gitgutter_max_signs = 2000

" VCOOLOR
" HEX
noremap Ç :VCoolor<CR>

" RGB
noremap ‰ :VCoolIns r<CR> 

syntax on

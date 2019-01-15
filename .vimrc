set nocompatible

call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'vim-syntastic/syntastic'
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
Plug 'vim-scripts/Vim-R-plugin'

Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'donRaphaco/neotex', { 'for': 'tex' }

call plug#end()

filetype plugin indent on

" UI changes
set mouse=a
set backspace=indent,eol,start

" AUTOCOMPLETE MENU
set wildmenu

" Include project root for fuzzy search
set path+=**

" Theme stuff
let g:quantum_black=1
let g:quantum_italics=1
let g:airline_theme='srcery'
let g:airline#extensions#tabline#enabled=1
set number
set background=dark
set termguicolors
colorscheme srcery

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" YCM C++ Settings
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_log_level='debug'
let g:ycm_server_keep_logfiles = 1
let g:ycm_path_to_python_interpreter='/anaconda3/bin/python'

" Add tag searching to root dir
set tags=tags

" Default file encoding to utf-8
set encoding=utf-8

" Localleader
let maplocalleader = ","

" Linter configuration
let g:ale_linters = {
			\'html': ['htmlhint'],
			\'javascript': ['eslint', 'flow']
			\}

" Allow Flow syntax
let g:javascript_plugin_flow=1

" Maps NerdTree to Alt-N -- OSX ONLY
noremap ˜ :NERDTreeToggle<CR>

" Finds the next placeholder and enters insert mode
nnoremap <Leader><Space><Space> <CR>/<++><CR>:noh<CR>da>i

autocmd FileType javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType scss setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType json setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType go setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType julia setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType tex setlocal ts=4 sw=4 sts=0 expandtab

augroup PythonSettings
	autocmd FileType python inoremap <S-tab> <C-o>:call ShiftTab()<CR>
	autocmd FileType python setlocal noshowmode
	autocmd FileType python noremap <Leader>;f <Esc>o<BS>def<Space><++>(<++>):<Enter><++><Esc>
augroup END

augroup JuliaSettings
	autocmd FileType julia noremap <Leader>;f <Esc>o<BS>function<Space><++>(<++>)<Enter><++><Enter>end<Esc>
augroup END

augroup TexSettings
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
	autocmd FileType xml setlocal ts=4 sw=4 sts=0 expandtab
augroup END

augroup RSettings
	autocmd FileType R setlocal ts=4 sw=4 sts=0 expandtab
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

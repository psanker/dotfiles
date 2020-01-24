set nocompatible

call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'KabbAmine/vCoolor.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-latex/vim-latex'
Plug 'dfm/shifttab.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'jalvesaq/Nvim-R'
Plug 'majutsushi/tagbar'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/csv.vim'

" Syntax and language support
Plug 'JuliaEditorSupport/julia-vim'
Plug 'fatih/vim-go'
Plug 'lumiliet/vim-twig'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" Themes
Plug 'kmszk/skyknight'
Plug 'srcery-colors/srcery-vim'
Plug 'ntk148v/vim-horizon'
Plug 'danilo-augusto/vim-afterglow'
"Plug 'YorickPeterse/happy_hacking.vim'
Plug 'psanker/happy_hacking.vim'

" nvim compat
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" ncm-r support
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'

" Custom R syntax
Plug 'psanker/R-Vim-runtime'

" Vim 8 only
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

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
set nohlsearch

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
set cursorline
set background=dark
set termguicolors
set t_Co=256
colorscheme happy_hacking
set laststatus=2
let g:lightline = {
    \ 'colorscheme' : 'seoul256',
    \ }

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

set tabstop=2 shiftwidth=2 softtabstop=0 expandtab

"autocmd FileType javascript setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType scss setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType json setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType go setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType julia setlocal ts=4 sw=4 sts=0 expandtab
"autocmd FileType tex setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType yaml setlocal ts=2 sw=2 sts=0 expandtab

" Don't hide the delimiter -- usually using vim to check the raw content
let g:csv_no_conceal=1

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0
nnoremap µ :MarkdownPreview<CR>

augroup FortranSettings
	autocmd!
	let fortran_free_source=1
	let fortran_have_tabs=1
	let fortran_more_precise=1
	let fortran_do_enddo=1
augroup END

augroup PythonSettings
    autocmd FileType python let maplocalleader="\\"
	autocmd FileType python inoremap <S-tab> <C-o>:call ShiftTab()<CR>
	autocmd FileType python setlocal noshowmode
	autocmd FileType python noremap <Leader>;f <Esc>o<BS>def<Space>():<CR><++><Esc>

    " Emulate \l and \ss from Nvim-R in python to SLIME
    autocmd FileType python vnoremap <LocalLeader>ss :'<,'>SlimeSend<CR>
    autocmd FileType python nnoremap <LocalLeader>l :SlimeSendCurrentLine<CR>
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
	autocmd FileType text set spell
augroup END

augroup XMLSettings
	autocmd!
	autocmd FileType xml setlocal ts=4 sw=4 sts=0 expandtab
augroup END

augroup MarkdownSettings
	autocmd!
	autocmd FileType markdown setlocal ts=4 sw=4 sts=0 expandtab
augroup END

augroup RSettings
	autocmd!
	"let vimrplugin_assign 
	let R_assign = 0
	let R_setwidth = 0
    let R_clear_line = 0
    let R_args_in_stline = 0

	autocmd FileType r nnoremap Â A<Space>%>%<Space>
	autocmd FileType r inoremap Â <Space>%>%<Space>
	autocmd FileType r inoremap [ []<Left>
	autocmd FileType r inoremap ( ()<Left>
	autocmd FileType r inoremap " ""<Left>
	autocmd FileType r inoremap ' ''<Left>

	autocmd FileType rmd nnoremap Â A<Space>%>%<Space>
	autocmd FileType rmd inoremap Â <Space>%>%<Space>
	autocmd FileType rmd inoremap [ []<Left>
	autocmd FileType rmd inoremap ( ()<Left>
	autocmd FileType rmd inoremap " ""<Left>
	autocmd FileType rmd inoremap ' ''<Left>

	autocmd FileType r set nofoldenable
	autocmd FileType rmd set nofoldenable

	let g:syntastic_enable_r_lintr_checker = 1
	let g:syntastic_r_checkers = ['lintr']
    let g:r_syntax_fun_pattern = 1

    let g:ale_r_lintr_options = 'with_defaults(
                \ object_usage_linter = NULL,
                \ line_length_linter(120),
                \ spaces_left_parentheses_linter = NULL)'
augroup END

augroup XMLSettings
	autocmd!
	com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

	autocmd FileType xml nnoremap = :FormatXML<CR>
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

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

syntax on

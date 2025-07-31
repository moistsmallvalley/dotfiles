" ============================================================
" plugins
" ============================================================
call plug#begin('~/.vim/plugged')
  " color themes
  Plug 'rhysd/vim-color-spring-night'
  Plug 'tjammer/blayu.vim'
  Plug 'jnurmine/Zenburn'
  Plug 'junegunn/seoul256.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'flrnd/candid.vim'
  Plug 'hzchirs/vim-material'
  Plug 'zefei/simple-dark'
  Plug 'relastle/bluewery.vim'
  Plug 'artanikin/vim-synthwave84'
  Plug 'cocopon/iceberg.vim'
  Plug 'rainglow/vim'
  " lsp
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " Plug 'mattn/vim-lsp-settings'
  " langs
  Plug 'posva/vim-vue'
  Plug 'fatih/vim-go'
  Plug 'tikhomirov/vim-glsl'
  Plug 'hashivim/vim-terraform'
  Plug 'sophacles/vim-processing'
  Plug 'udalov/kotlin-vim'
  " tools
  Plug 'scrooloose/nerdtree'
  Plug 'jamessan/vim-gnupg'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'vim-test/vim-test'
  " Plug 'cohama/lexima.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'dense-analysis/ale'
  Plug 'vim-scripts/DrawIt'
call plug#end()

" ============================================================
" options
" ============================================================
set incsearch ignorecase smartcase
" set autochdir
set hidden
"set nowrap
set nonumber
set noswapfile
set mouse=a
set backspace=indent,eol,start
set autoindent smartindent expandtab
set tabstop=4 shiftwidth=4 cinoptions=l1
set history=10000
set background=dark
set laststatus=2
set guicursor=a:blinkon0
set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" colorscheme seoul256
" colorscheme nord
" colorscheme mynord
colorscheme absent-light
" hi Normal guifg=#ffffff
hi Comment ctermfg=gray guifg=#aabbcc
" hi Comment guifg=#aabbcc cterm=none
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi SpecialKey ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE

" ============================================================
" remove trailing whitespaces
" ============================================================
augroup space
    au!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" ============================================================
" filetype
" ============================================================
filetype plugin indent on
augroup fileTypeIndent
  au!
  au BufRead,BufNewFile *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.tsx setlocal tabstop=3 softtabstop=3 shiftwidth=2
  au BufRead,BufNewFile *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.c setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.cc setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.mm setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.m setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.h setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.hpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.vert setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.frag setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" ============================================================
" keymap
" ============================================================
inoremap <silent> <C-b> <left>
inoremap <silent> <C-f> <right>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-e> <End>
inoremap <silent> <C-d> <Del>

cnoremap <C-f> <right>
cnoremap <C-b> <left>
cnoremap <C-p> <up>
cnoremap <C-n> <down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" ============================================================
" lsp
" ============================================================
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if executable('gopls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })
  autocmd BufWritePre *.go LspDocumentFormatSync
  autocmd BufWritePre *.go call execute('LspCodeActionSync source.organizeImports')
  let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
endif

if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescriptreact'],
        \ })
  autocmd BufWritePre *.ts,*.tsx LspDocumentFormatSync
  " autocmd BufWritePre *.ts,*.tsx call execute('LspCodeActionSync source.organizeImports')
endif

if executable('pylsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'whitelist': ['python'],
        \ })
  autocmd BufWritePre *.py LspDocumentFormatSync
endif

if executable('clangd')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'cc', 'm', 'mm', 'objc'],
        \ })
  autocmd BufWritePre *.cc LspDocumentFormatSync
  autocmd BufWritePre *.mm LspDocumentFormatSync
  autocmd BufWritePre *.h LspDocumentFormatSync
endif

if executable('/Applications/Xcode.app/Contents//Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['/Applications/Xcode.app/Contents//Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

if executable('terraform-ls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'terraform-ls',
        \ 'cmd': {server_info->['terraform-ls', 'serve']},
        \ 'whitelist': ['terraform'],
        \ })
  autocmd BufWritePre *.tf LspDocumentFormatSync
endif

if executable('omnisharp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'omnisharp',
        \ 'cmd': {server_info->['omnisharp']},
		\ 'root_uri':{server_info->lsp#utils#path_to_uri(
		\	lsp#utils#find_nearest_parent_file_directory(
		\		lsp#utils#get_buffer_path(),
		\		['Assembly-CSharp.csproj', '.git', '.git/']
		\	))},
        \ 'whitelist': ['cs'],
        \ })
  autocmd BufWritePre *.cs LspDocumentFormatSync
endif

if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'Rust Language Server',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
  autocmd BufWritePre *.rs LspDocumentFormatSync
endif

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')


function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)"setlocal signcolumn=yes
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================
" lint
" ============================================================
let g:ale_pattern_options = {
      \ '\.\(cc\|cpp\|cxx\|c\|h\|m\|mm\|py\)': {'ale_enabled': 0}
      \ }
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ }
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
let g:ale_javascript_prettier_use_local_config = 1

" ============================================================
" fzf
" ============================================================
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
"
" ============================================================
" gpg
" ============================================================
let g:GPGExecutable = "gpg"
let g:GPGPreferSymmetric = 1





set encoding=utf8
syntax on
set background=dark
filetype plugin indent on

"==========display==========
set number		" show line number 
set showmode 		" show mode 
set title		" show editting file
set ruler 		" show ruler
set showcmd		" show command status 
set showmatch		" show parenthesis
set scrolloff=5		" set scroll row number
set cursorline		" highlight current line
set list
set listchars=tab:»-,trail:▸    "visualize unseen character
set laststatus=2        "show status line

" show double-byte space
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"========== operation==========
set autoread		" update file automaticaly
set expandtab 		" insert space character insted tab
inoremap <silent> jj <ESC> 	" change from insert to command by typping jj" 
set nosi                " disable smartindext
set tabstop=2 shiftwidth=2 softtabstop=2        "set indent space
set backspace=2

"========== search==========
set wrapscan
set ignorecase
set smartcase
set noincsearch

" ============ neobundle ===============
function! s:WithoutBundles()
  "colorscheme desert
endfunction

if has('vim_starting')
  if &compatible
     set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" ======== plugin =========
function! s:LoadBundles()
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundleLazy 'Shougo/neosnippet'
  NeoBundle "ctrlpvim/ctrlp.vim"
  NeoBundle "Shougo/neocomplete"
  NeoBundle "scrooloose/nerdtree"
  NeoBundle "tpope/vim-haml"
  NeoBundle 'basyura/unite-rails'
  NeoBundle 'ujihisa/unite-rake'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'szw/vim-tags'
  NeoBundle 'supermomonga/neocomplete-rsense.vim'
  NeoBundle 'scrooloose/syntastic'

  if has('lua')
    NeoBundleLazy 'Shougo/neocomplete', {
     \   'depends' : ['Shougo/neosnippet', 'Shougo/context_filetype.vim'],
     \   'autoload' : {
     \       'insert' : 1,
     \   }
     \}
  endif

  " colorschemes
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'vim-scripts/twilight'
  NeoBundle 'jonathanfilip/vim-lucius'
  NeoBundle 'jpo/vim-railscasts-theme'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'vim-scripts/Wombat'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'vim-scripts/rdark'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'jpo/vim-railscasts-theme'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'vim-scripts/rdark'

  " plugin settings
  " for Unite
  let g:unite_enable_start_insert=1
  " for neomru
  let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "
  noremap :um :Unite file_mru

  " rense
  let g:rsenseUseOmniFunc = 1
endfunction

" call LoadBundles() if Neobundle was installed, otherwise call WithoutBundles()
function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    try
      call neobundle#begin(expand('~/.vim/bundle/'))
        call s:LoadBundles()
      call neobundle#end()
    catch
      call s:WithoutBundles()
    endtry
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()

" settings neocomplete
if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#force_overwrite_completefunc = 1

  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif

  let g:neocomplete#keyword_patterns._ = '\h\w*'

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
end

autocmd VimEnter * execute 'NERDTree'
autocmd QuickFixCmdPost *grep* cwindow

set nu


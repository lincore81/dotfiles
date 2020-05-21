
""""""""""""""""""""""""":VISUAL APPEARENCE:"""""""""""""""""""""""""
" set t_Co=256
" set termguicolors
let &colorcolumn=join(range(81,82), ",")
let g:lightcolors="xcode-default"
let g:darkcolors="znake2"
" execute "colorscheme " . g:darkcolors
set cursorline

""""""""""""""""""""""""":EDITOR BEHAVIOUR:"""""""""""""""""""""""""
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" syntax on
" relative + absolute line numbers:
set relativenumber
set number
set foldlevelstart=99
set foldmethod=syntax
set clipboard+=unnamedplus " implicitly use the clipboard
set encoding=utf-8
set textwidth=80
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set hidden
set bufhidden=hide
set backupcopy=yes " for webpack
set backupdir^=~/.config/nvim/backup,/tmp
set nowrap
set ruler " show the cursor position all the time
set showcmd " display incomplete commands

" backup
if has("vms")
    set nobackup        " do not keep a backup file, use versions instead
else
    set backup		" keep a backup file (restore to previous version)
    set undofile	" keep an undo file (undo changes after closing)
endif

set path+=**
set mouse=a
" Display all matching files for tab completion:
set wildmenu
set wildmode=longest,full
set wildignorecase

""""""""""""""""""""""""":KEY MAPPINGS:"""""""""""""""""""""""""
let mapleader=" "

nnoremap <Leader>W :set wrap!<Esc>
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
nnoremap <Leader>i i_<Esc>r
nnoremap <Leader>B a<CR><Esc>
nnoremap <Leader>b :b#<Esc>
nnoremap <Leader>a :ALEDetail<Esc>
nnoremap <expr> <leader>v ":".winwidth(0)/3*2."vsplit\<CR>"

nnoremap <Leader>h ^wh
nnoremap <Leader>j ^wj
nnoremap <Leader>k ^wk
nnoremap <Leader>l ^wl
nnoremap <Leader>c ^wc

" move text up a line:
nnoremap <up> kddpk 
" move text down a line:
nnoremap <down> ddp 

nnoremap <left> :bnext<CR>
nnoremap <right> :bprevious<CR> 
nnoremap <Leader>c :call ToggleColors()<CR>
noremap  <Leader>. :e ~/.config/nvim/init.vim<CR>
noremap  <Leader><esc> :set hlsearch!<CR>
noremap  <Leader>N :set relativenumber!<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>




""""""""""""""""""""""""":AUTO COMMANDS:"""""""""""""""""""""""""
 autocmd BufWinLeave *.* mkview
 autocmd BufWinEnter *.* silent! loadview


augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text setlocal textwidth=80
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END

" au BufRead * normal zR

" SvelteJS -> HTML
au! BufNewFile,BufRead *.svelte set ft=html



""""""""""""""""""""""""":PLUGINS:"""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
    "Plug 'Shougo/vimproc'
    Plug 'tpope/vim-surround'       " surround motion
    Plug 'vim-airline/vim-airline'  " statusbar bling
    Plug 'w0rp/ale'                 " lint engine
    Plug 'kien/ctrlp.vim'           " fuzzy finder
    Plug 'dylanaraps/wal.vim'       " pywal colorscheme bling
    Plug 'Shougo/deoplete.nvim'     " For async completion

    " HASKELL
    Plug 'neovimhaskell/haskell-vim'
    Plug 'eagletmt/ghcmod-vim'

    " HTML
    Plug 'alvan/vim-closetag'

    " TYPESCRIPT
    Plug 'HerringtonDarkholme/yats.vim' " Typescript syntax file
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
call plug#end()

let g:airline#extensions#ale#enabled = 1
" let g:airline_powerline_fonts = 1

let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('auto_complete', v:false)

autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
let g:ale_linters = {
    \   'haskell': ['stack-ghc', 'hlint', 'hdevtools', 'hfmt'],
    \}


" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
" let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

""""""""""""""""""""""""":UTILS:"""""""""""""""""""""""""

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

function ToggleColors()
    if (g:colors_name == g:lightcolors)
        execute "colorscheme " . g:darkcolors
    else
        execute "colorscheme " . g:lightcolors
    endif
    highlight Comment cterm=italic gui=italic
endfunction

colorscheme default
highlight CursorLine term=NONE cterm=NONE ctermbg=16
highlight Comment cterm=italic gui=italic

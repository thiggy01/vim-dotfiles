" Vim Configuration File
" ======================

" Basic settings
" {{{1

set nocompatible " Extend Vi capabilities through Vim extensions.
set nomodeline " Avoid being exposed to security vulnerabilities of modelines.
set backup " keep a backup file to restore to previous version.
set undofile    " keep an undo file to undo changes after closing.
set swapfile " keep a swap file of last unsaved changes.
set backupdir=~/.vim/backup,.,/tmp " Set a default directory for backup files.
set undodir=~/.vim/undo,.,/tmp " Set a default directory for undo files.
set directory=~/.vim/swap,.,/tmp " Set a default directory for swap files.
set mouse=a "Enable mouse usage when support is available.
set laststatus=2 " Always display the status bar.
set wildmenu " Display command line completion matches in status bar.
set ruler " Show complete cursor position in status bar.
set cursorline "Highlight the current cursor position line.
set showcmd " Show partial commands at the right corner of the last line.
set display=truncate " Show @ in the last lines of buffer if it is truncated.
set history=200 " keep 200 lines of command line history.
set incsearch " Show pattern as it was typed so far, if it matches.
set scrolloff=5 " Keep your cursor vertically centered.
set ttimeout " Enable time out when using key codes.
set ttimeoutlen=100 " Wait X ms after key code for special key.
set timeoutlen=1000 " Wait X ms after first mapped key for remaining keys.
set autowriteall " Automatically write to files on specific commands.
set backspace=indent,eol,start " Allow a more powerful backspacing.
set tabstop=4 " Number os spaces inserted when pressing tab.
set shiftwidth=4 " Number of spaces inserted when using indentation commands.
set autoindent " Copy indent from current line when starting a new line.
set expandtab " Expand tab to spaces when autoindent is on.
let g:vim_indent_cont = &sw " Set line continuation indentation to shiftwidth.
set list " Enable the list mode in order to show tab and space as characters.
set listchars=tab:\|\ ,trail:- " change tab and trail spaces to >- and - chars.
set foldmethod=indent " Set the default fold method to indent.
" }}}

" Advanced Settings
" {{{1

" Load specific plugin and indentation files.
filetype plugin indent on

" Set syntax highlighting on.
syntax enable

" Remove a preview window during autocompletion.
set completeopt-=preview

" Highlight the cursor line background.
highlight CursorLine term=bold cterm=bold ctermbg=238
highlight CursorLineNr term=bold cterm=bold ctermbg=238

" Main autocommand group.
augroup advanced
    autocmd!
    " Jump to the last cursor posiion when you reopen a file.
    autocmd BufRead * :normal! `"
     " Open all indented folds.
    autocmd BufRead * :normal! zR
     " Jump to the last edited position when sourcing .vimrc.
    autocm SourcePost * :silent! normal! `.
    " Avoid highlighting the last search when sourcing vimrc.
    autocmd BufEnter * setlocal hlsearch
    " Remove all trailing white spaces from file when saved.
    autocmd BufWritePre * :silent! %s/\s\+$//
    " Override colorscheme cursor line highlighting default configuration.
    autocmd ColorScheme * highlight CursorLine term=bold cterm=bold ctermbg=238
    autocmd ColorScheme * highlight CursorLineNr term=bold cterm=bold ctermbg=238
    " Set the auto-complete configuration.
    autocmd Filetype *
    \| if &omnifunc == ""
    \|       setlocal omnifunc=syntaxcomplete#Complete
    \| endif
    \| if &omnifunc != ''
    \|       call SuperTabChain(&omnifunc, "<C-n>")
    \| endif
augroup END
" 1}}}

" Specific Settings
" {{{1
" Plugin Manager Pathogen settings.
" Load plugins to vim runtime.
execute pathogen#infect('bundle/{}')
" Generate helptags.
execute pathogen#helptags()

" Clang Complete settings.
" Path to acess clang library directly for clang completion plugin.
let g:clang_library_path = '/usr/lib/llvm-10/lib/libclang.so.1'
" Use snippets to add argument placeholders to code.
let g:clang_snippets = 1

" Supertab settings.
" Set the default completion to the file context.
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"

" Vim Airline settings.
" Enable smarter tab line.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
" Enable powerline symbols and branches.
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" Set colorscheme to use OceanicNext.
set termguicolors
let g:airline_theme='oceanicnext'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Netrw Settings.
" Make tree list the default view.
let g:netrw_liststyle = 3
" Remove the directory banner permanently.
let g:netrw_banner = 0
" Open files in a vertical split window.
le g:netrw_browse_split = 2
" Set the width of the explorer to 25% of the page.
let g:netrw_winsize = 25

" include js and jsx filetypes to autoclose tags.
let g:closetag_filenames = '*.htm, *.html, *.xhtml, *.phtml, *.js, *.jsx'

" Draw a NERDTree explorer when opening something with vim.
" augroup project_explorer
"   autocmd!
"   autocmd VimEnter * :NERDTree
" augroup END

" Filetype settings.
" {{{2

" Specifi filetype commands.
augroup filetype_commands
    autocm!
    " Stop vim from autocommenting on vimscripts.
    autocmd Filetype vim setlocal formatoptions-=cro foldmethod=marker
    " Set indentation of 2 spaces for javascript.
    autocmd Filetype javascript,javascriptreact,json,html,xhtml setlocal tabstop=2 shiftwidth=2
    \| execute "normal zR"
augroup END
" 2}}}
" 1}}}

" Ke Mappings
" {{{1

" General
"{{{2
" Change vim default leader key to space key.
let mapleader = " "

" copy, cut and paste keys from/to clipboard.
" Need to instal vim-gtk3 for this to work.
" Movement pending copy and cut.
noremap <leader>c "+y
noremap <leader>x "+d
" Paste content after the cursor.
noremap <leader>v "+p
"2}}}

" Insert mode
" {{{2

" Map escape key to jj in insert mode only.
inoremap jj <Esc>

" Autocompletion.
" Filename completion.
inoremap <C-x>f <C-x><C-f>
" Context-aware word completion.
inoremap <C-x>n <C-x><C-n>
" Context-aware line completion.
inoremap <C-x>l <C-x><C-l>

" Exit the completion popup menu with Esc.
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
" Select the highlighted item on the popup menu with Enter.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" " Braces, brackets and parentheses expansion.
" inoremap {<CR> {<CR>}<Esc>O
" inoremap [<CR> [<CR>]<Esc>O
" inoremap (<CR> (<CR>)<Esc>O
" inoremap ><CR>    ><CR><Esc>O
" 2}}}

" Normal mode
" {{{2

" Add N new lines below or above the current line and enter insert mode.
nnoremap <leader>o o<Esc>S
nnoremap <leader>O O<Esc>kS

" Go to the middle of current line.
nnoremap <leader>m :call cursor(0, len(getline('.'))/2)<CR>

" open a help topic.
nnorema <leader>h :help<Space>

" Open and source .vimrc on the go.
nnoremap <leader>evr :edit $MYVIMRC<CR>
nnoremap <leader>svr :source $MYVIMRC \| e %<CR>

" Disable highlighted matches after searching.
nnoremap <silent> <leader><CR> :nohlsearch<CR>
" Enable or disable spellchecking.
nnoremap <leader>spc :silent! set spell! spelllang=en_us<CR>
" Toggle relative and absolute line number.
nnoremap <leader>ln :silent! set relativenumber! number!<CR>

" Buffer navigation commands mapping.
" Go to the alternate buffer.
nnoremap <leader>bb <C-^>
" Jump to buffer.
" [count]<leader>j.b
" Delete the current buffer.
nnoremap <leader>db :bd<CR>
" Use the same keys as tabs do.
" Go to next buffer.
nnoremap <leader>gb :bn<CR>
" Go to previous buffer.
nnoremap <leader>gB :bp<CR>

" Save current buffer to its correspondent file.
nnoremap <leader>w :w<CR>
" Quit from file/window/buffers without saving.
nnoremap <leader>q :q!<CR>

" copy/cut text to the "0 registry instead of the unamed one.
nnoremap <leader>y "0y
nnoremap <leader>d "0d

" Shell script settings.
"Comment/uncomment multiple shell script lines.
" nnoremap <leader>\ :normal! i# <CR>
" nnoremap <leader>n\ :normal! 2x<CR>

" Inspect shell scripts syntax in shellcheck.
nnoremap <leader>sh :!clear && shellcheck %<CR>

" " Open NEEDTree explorer.
" nnoremap <leader>exp :NERDTree<CR>

" 2}}}

" Command line mode
" {{{2
" Go to the beggining of the line.
cnoremap <C-a> <Home>
" Go to the nude of the line.
cnoremap <C-e> <End>
" Go one character to the right.
cnoremap <C-f> <Right>
" Go one character to the left.
cnoremap <C-b> <Left>
" Make vim reconize Alt + f and Alt + b mapping sequences.
execute "set <A-b>=b"
execute "set <A-f>=f"
" Go one word to the right.
cnoremap <A-f> <S-Right>
" Go one word to the left.
cnoremap <A-b> <S-Left>
" Delete the character under the cursos.
cnoremap <C-d> <Del>
" 2}}}

" Complex
" {{{2
" Fix the behavior of the inner tag object to indent as expected.
" This solution was posted by @jair-lópez on https://vi.stackexchange.com/q/13050/25511
function! FixInnerTag()
    " Get the position of the first line of the selected inner tag object.
    let openingMark =  getpos("'<")
    " Get the position of the last line of the selected inner tag object.
    let closingMark = getpos("'>")
    " Check whether both marks are on the same line.
    if openingMark[1] != closingMark[1]
        " Get the lines where the marks are on.
        let openingLine = getline(openingMark[1])
        let closingLine = getline(closingMark[1])
        " Check whether there's nothing appended to the opening tag.
        if match( openingLine, '\S',    openingMark[2] - 1) == -1
            " Check whether the closing tag is at the beginning of the line.
            if match( closingLine, "$" ) + 1    ==  closingMark[2]
                " Restore and adjust the last Visual area.
                normal! gvVojo
                return
            " Check whether there's nothing prepended to the closing tag.
            elseif  match( closingLine, '\S\%<' . closingMark[2] . "c" ) == -1
                " Restore and adjust the last Visual area.
                normal! gvVkojo
                return
            endif
        endif
    else
      " Do nothing. Restore the last Visual area.
      normal! gv
    endif
endfunction
" Call the fix so the it object runs as expected.
omap it :normal vit<CR>
vnoremap it it:<C-u>call FixInnerTag()<CR>
" 2}}}
" 1}}}

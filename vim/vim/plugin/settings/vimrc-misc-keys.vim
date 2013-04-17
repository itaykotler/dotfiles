" ========================================
" General vim sanity improvements
" ========================================
"
"
" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>ow "_diwhp

"make Y consistent with C and D
nnoremap Y y$

" ========================================
" RSI Prevention - keyboard remaps
" ========================================
" Certain things we do every day as programmers stress
" out our hands. For example, typing underscores and
" dashes are very common, and in position that require
" a lot of hand movement. Vim to the rescue
"
" Now using the middle finger of either hand you can type
" underscores with apple-k or apple-d, and add Shift
" to type dashes
imap <silent> <D-k> _
imap <silent> <D-d> _
imap <silent> <D-K> -
imap <silent> <D-D> -

" ========================================
" misc
" ========================================
" gary bernhardt's hashrocket
imap <c-l> <space>=><space>

" Semicolon at end of line by typing ;;
inoremap ;; <C-o>A;<esc>

" Change inside various enclosures with Cmd-" and Cmd-'
" The f makes it find the enclosure so you don't have
" to be standing inside it
nnoremap <D-'> f'ci'
nnoremap <D-"> f"ci"
nnoremap <D-(> f(ci(
nnoremap <D-)> f)ci)
nnoremap <D-[> f[ci[
nnoremap <D-]> f]ci]

"When typing a string, your quotes auto complete. Move past the quote
"while still in insert mode by hitting Ctrl-a. Example:
"
" type 'foo<c-a>
"
" the first quote will autoclose so you'll get 'foo' and hitting <c-a> will
" put the cursor right after the quote
imap <C-a> <esc>wa

" ==== NERD tree
noremap <F2> :NERDTreeTabsToggle<CR>
" Open the project tree and expose current file in the nerdtree with Shift-F2
nnoremap <silent> <S-F2> :NERDTreeFind<CR>:vertical res 30<CR>

" ,q to toggle quickfix window (where you have stuff like GitGrep)
" ,oq to open it back up (rare)
nmap <silent> <leader>qc :cclose<CR>
nmap <silent> <leader>qo :copen<CR>
" Q is for entering the Ex mode, and we don't like to be there
nnoremap Q <nop>

"(v)im (r)eload
nmap <silent> <leader>vr :so %<CR>:echo 'Reloaded!'<CR>

" Apple-* Highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <D-*> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

"Clear current search highlight by double tapping //
nmap <silent> \\ :nohlsearch<CR>

" Spelling related stuff
nnoremap <leader>s :set spell!<CR>

" Git commits.
autocmd FileType gitcommit setlocal spell
" Subversion commits.
autocmd FileType svn       setlocal spell
" Mercurial commits.
autocmd FileType asciidoc  setlocal spell

inoremap jk <esc>

noremap H 0
noremap L $

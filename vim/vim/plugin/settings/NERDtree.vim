" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" keys
" ===========
" because we use NERDTree Tabs Toggle the mapping is nor here
"noremap <F2> :NERDTreeTabsToggle<CR>

" Open the project tree and expose current file in the nerdtree with Shift-F2
noremap <silent> <S-F2> :NERDTreeFind<CR>:vertical res 30<CR>
"

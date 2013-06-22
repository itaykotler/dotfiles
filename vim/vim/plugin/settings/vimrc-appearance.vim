" Make it beautiful - colors and fonts
if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  " http://ethanschoonover.com/solarized/vim-colors-solarized
  "colorscheme solarized
  colorscheme railscasts
  "colorscheme peachpuff
  "colorscheme yella
  "colorscheme xoria256

  set background=dark
  "set background=light

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  "set lines=60
  "set columns=190

  "===============================================================================
  " Fonts
  "===============================================================================
  if has("gui_running")
    if has('mac') || has('macunix')
      " set guifont=Inconsolata-dz-Powerline:h18
      " set guifont=PragmataPro:h18
      set guifont=Anonymous\ Pro:h18
      "set guifont=Inconsolata\ XL:h17,Inconsolata:h20,Monaco:h17
    elseif has('unix')
      " set guifont=PragmataPro:h18
      set guifont=Anonymous\ Pro\ 14
      "set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
      "set guifont=Monaco:h14
      "set guifont=Courier New:h13
      "set guifont=Menlo:h14
    endif
  endif
else
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1
endif

if !has("gui_macvim")
  set t_Co=256
  let g:solarized_termcolors=256
endif

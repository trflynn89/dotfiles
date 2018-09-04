" COLORS
syntax enable       " enable syntax processing

" SPACES AND TABS
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set autoindent
filetype indent on  " load filetype specific indent files

" UI CONFIG
set ruler           " show ruler
set number          " show line number
set nuw=4
set cursorline      " highlight current line
set wildmenu        " visual complete for command menu
set lazyredraw      " redraw only when we need to.
set showmatch       " highlight matching [{()}]

" SEARCHING
set ignorecase
set incsearch       " search as characters are entered
set hlsearch        " highlight matches

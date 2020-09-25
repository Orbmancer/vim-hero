set mouse=a
syntax enable
colorscheme gruvbox
set background=dark
set visualbell
set relativenumber

call plug#begin()

Plug 'pangloss/vim-javascript'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Townk/vim-autoclose'
Plug 'bit2pixel/vim-togglemouse'
Plug 'itchyny/lightline.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'morhetz/gruvbox'
"Plug 'vim-syntastic/syntastic'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'zenbro/mirror.vim'
Plug 'derekwyatt/vim-scala'
Plug 'bkad/CamelCaseMotion'
Plug 'craigemery/vim-autotag'
Plug 'benmills/vimux'
"Plug 'mhinz/vim-startify'
Plug 'terryma/vim-multiple-cursors'
Plug 'amadeus/vim-mjml'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'takac/vim-hardtime'
Plug 'alvan/vim-closetag'
Plug 'slim-template/vim-slim'
Plug 'beyondwords/vim-twig'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-endwise'
Plug 'leafgarland/typescript-vim'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tpope/vim-rails'
"Plug 'jewes/Conque-Shell'

" fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'

call plug#end()

au BufNewFile,BufRead *.es6 setf javascript "vim-javascript syntax for .es6 files
au BufNewFile,BufRead *.fish setf sh "fish config files

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra' "nearest ancestor containing .git folder
let g:ctrlp_switch_buffer = 'et' "opens file in new pane
"custom ctrlp ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] "ignore files in .gitignore

map <C-n> :NERDTreeToggle<CR>

set number "show line numbers
set expandtab "converts tabs to spaces
set tabstop=2 "tab => 2 spaces
set shiftwidth=2 "ident => 2 spaces
set list "show tabs character"

augroup python_files
    autocmd!
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
augroup END

"let g:jsx_ext_required = 0 "vim-jsx: jsx format also for .js files

let g:gruvbox_contrast_dark = 'soft'

set hlsearch "highlight matching phrases
set ignorecase "you nearly always want this
set smartcase  "case-sensitive if search contains an uppercase character

"syntastic configurations
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jscs']

autocmd BufWritePre * %s/\s\+$//e "removes trailing whitespaces before saving

" Change Color when entering Insert Mode
autocmd InsertEnter * set cursorline

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * set nocursorline

" map control+c to escape
inoremap <C-C> <Esc>

"Paste in visual mode again and again
xnoremap p pgvy

" Set Leader key and use camelCaseMotion default mappings
let mapleader = ','
call camelcasemotion#CreateMotionMappings('<leader>')

autocmd FileType php setlocal shiftwidth=4 tabstop=4 "indent size only for php (my use case)

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

"show the current command being entered
set showcmd

"pgsql select current function
map <Leader>vf ?create .* function<Enter><S-V>/\$\$ language<Enter>"*y``zz:noh<Enter>
"pgsql select current test
map <Leader>vt ?begin;<Enter><S-V>/rollback<Enter>"*y

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" move text and re-highlight
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" search for visually selected text
vnoremap // y/<C-R>"<CR>

" hard time mode
let g:hardtime_default_on = 1

" delete attribute
map <Leader>da F d2f"

" add class
map tc vath%<Esc>f>i class=""<Esc>hi

" associate *.mustache with html filetype
augroup filetypedetect
    au BufRead,BufNewFile *.mustache setfiletype html
augroup END

" macros trigger rerender only at the end of their execution
set lazyredraw

" alvan/vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.mustache,*.md,*.twig'

" markdown bold surround
" I personnaly also mapped OSX Command + B to <C-B> via iTerm2 (using hex code 0x02)
nnoremap <C-b> ciw****<Esc>h<S-P>
vnoremap <C-b> c****<Esc>h<S-P>

" <a href=""></a> helper with visual selection and clipboard url
vnoremap <C-a> c<a href="" target="_blank"></a><Esc>?href=""<CR>5l"*pvit<Esc><S-p>

" emoji helper
" nnoremap <C-I> a<i class="twa twa-"></i><Esc>5hi

" ruby quick log
autocmd FileType ruby nnoremap <C-L> $v0wyip "<Enter><Esc>k$:r ! sh ~/.vim/random_emoji.sh<Enter>kJJ$a #{<Esc>pA}"<Esc>0f"lxf{l
autocmd FileType javascript nnoremap <C-L> $v0wyiconsole.log('<Enter><Esc>k$:r ! sh ~/.vim/random_emoji.sh<Enter>kJJ$a ', <Esc>pA)<Esc>0f"lxf{l

" ruby tap log
" nnoremap <S-T> o.tap{|x| p "🚰 #{x}"}<Esc>

" minimap
let g:minimap_toggle='<C-M>'

" git-gutter
function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

nmap gn :call GitGutterNextHunkCycle()<CR>
nmap gN :call GitGutterNextHunkCycle()<CR>

" vim-rails config
let g:rails_projections = {
      \  "app/controllers/*.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_spec.rb",
      \        "test/controllers/{}_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_spec.rb",
      \        "test/controllers/{}_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}.rb",
      \      "template": [
      \        "# frozen_string_literal: true",
      \        "",
      \        "require 'rails_helper'",
      \        "",
      \        "describe {camelcase|capitalize|colons} do",
      \        "end"
      \      ]
      \   },
      \   "spec/javascript/*.spec.js": {
      \     "alternate": "app/javascript",
      \     "railsRunner": "jest"
      \   }
      \ }
" shortcut to launch rspec/jest
command Test :Runner
command Tes :Runner
command Run :Runner

" load ctags for files
autocmd FileType ruby set tags=./ruby_tags,ruby_tags;./tags,tags;
autocmd FileType javascript set tags=./js_tags,js_tags;./tags,tags;

"neoterm
let g:neoterm_shell = '/bin/zsh'
let g:neoterm_default_mod = 'vertical'
let g:neoterm_term_per_tab = 1 " Different terminal for each tab
let g:neoterm_auto_repl_cmd = 0 " Do not launch rails console on TREPLsend

